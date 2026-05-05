/*
 * GranularSynth — ESPdLib example
 *
 * 4-voice granular synthesizer. A LittleFS sample is read by overlapping
 * grains, each windowed by a Hann envelope. Four phase-offset phasors
 * stagger grain onsets to keep the texture continuous at low rates.
 *
 * Per-voice DSP (transpose decoupled from grain rate):
 *   step         = transpose * sample_rate / (grain_rate * (table_size - 3))
 *   sample idx   = wrap(voice_phi * step + frozen_pos) * (table_size - 3) + 1
 *   window idx   = clip(voice_phi / grain_size, 0, 1) * 511
 *   voice out    = tabread4~ sample * tabread4~ wndw
 *   samphold~ freezes grain_pos at each phasor reset.
 *   Hann tail (~0) outside the active fraction acts as the duty-cycle gate.
 *
 * Master:
 *   sum(4 voices) * 0.5 * gate_env * amp_line~ -> hip~ -> clip~ -> dac~
 *
 * Hardware (Adafruit ESP32 Feather V2 + MAX98357A I2S DAC):
 *   I2S       BCLK=27, LRC=33, DIN=15
 *   pot1      GPIO36 -> grain_pos    (0–1, lin)
 *   pot2      GPIO39 -> grain_rate   (1–30 Hz, exp)
 *   pot3      GPIO34 -> grain_size   (0.05–0.5, lin)
 *   pot4      GPIO37 -> transpose    (0.5–2.0, exp; unity at pot midpoint)
 *   but1      GPIO14 -> gate toggle
 *   led1      GPIO32 -> gate indicator
 *
 * Upload data/ to LittleFS before flashing.
 *
 * Already covered: grain_rate, grain_size (as duty cycle), position,
 *   transpose, voices=4, Hann window, master amp+gate, cubic interp (tabread4~).
 *
 * Possible extensions:
 *   - pos_jitter / pitch_jitter: random scatter per grain onset (noise~ + samphold~)
 *   - density_probability: stochastic per-onset gate (random < threshold)
 *   - scan_rate: LFO on grain_pos to auto-walk the sample
 *   - freeze: toggle to halt scan_rate (or pot/buffer advance)
 *   - reverse: multiply step by -1
 *   - loop mode: wrap vs stop at sample end
 *   - variable window shape: switch between multiple wndw tables (Hann/Gauss/tri)
 *   - sample switching: long-press button to cycle through data/*.{aiff,wav}
 *   - stereo + per-grain pan (requires PCM5102 DAC upgrade)
 *   - OSC over WiFi for remote parameter control
 */

#include <ESPdLib.h>
#include <MultiControl.h>
#include <LittleFS.h>

// libpd's patch loader recurses with ~1 KB of locals per level; the default
// 8 KB Arduino loopTask stack overflows during openPatch().
SET_LOOP_TASK_STACK_SIZE(32 * 1024);

#define DEBUG  // comment out to silence per-control prints

// --- Pins ---
#define PIN_POT1     36
#define PIN_POT2     39
#define PIN_POT3     34
#define PIN_POT4     37
#define PIN_BUT1     14
#define PIN_LED1     32

// --- I2S (MAX98357A) ---
#define PIN_I2S_BCLK 27
#define PIN_I2S_WS   33
#define PIN_I2S_DOUT 15

// --- Pd patch and sample (16/24-bit PCM AIFF or WAV; mono or stereo→mono) ---
#define PATCH_FILE   "granular.pd"
#define SAMPLE_FILE  "/chiko.aiff"

// --- Sample table ---
// 10 s at 44.1 kHz = 441000 samples × 4 B = 1.76 MB. Lives in PSRAM.
// Enable Tools → PSRAM → Enabled in the Arduino IDE.
#define MAX_SAMPLES  441000

// --- Pot calibration (MultiControl output, 0–1022 scale) ---
// If readings don't reach 0/1022, raise POT_MIN / lower POT_MAX accordingly.
#define POT_MIN     0.0f
#define POT_MAX  1022.0f

// MultiControl ctor: type 1 = potentiometer, 2 = button.
MultiControl pot1(PIN_POT1, 1);
MultiControl pot2(PIN_POT2, 1);
MultiControl pot3(PIN_POT3, 1);
MultiControl pot4(PIN_POT4, 1);
MultiControl btn1(PIN_BUT1, 2);

bool lastBtn = false, gate = false;

void onPdPrint(const char* msg) { Serial.printf("[Pd] %s", msg); }

inline float normalize(int raw) {
    return constrain((raw - POT_MIN) / (POT_MAX - POT_MIN), 0.0f, 1.0f);
}

inline float scaleLin(int raw, float lo, float hi) {
    return lo + normalize(raw) * (hi - lo);
}

// Logarithmic mapping; gives unity at pot midpoint for symmetric ratios. Requires lo > 0.
inline float scaleExp(int raw, float lo, float hi) {
    return lo * powf(hi / lo, normalize(raw));
}

// --- Pot → Pd parameter mapping ---
// Each row binds a pot to a Pd receiver, value range, and curve (scaleLin or scaleExp).
struct PotMap {
    MultiControl* mc;
    int           pin;
    const char*   pdName;
    float         minVal;
    float         maxVal;
    float       (*scale)(int, float, float);
};

PotMap pots[] = {
    { &pot1, PIN_POT1, "grain_pos",  0.0f,  1.0f,  scaleLin },
    { &pot2, PIN_POT2, "grain_rate", 1.0f,  30.0f, scaleExp },
    { &pot3, PIN_POT3, "grain_size", 0.05f, 0.5f,  scaleLin },
    { &pot4, PIN_POT4, "transpose",  0.5f,  2.0f,  scaleExp },
};

// ---------------------------------------------------------------------------
// Sample loader (AIFF + WAV)
// ---------------------------------------------------------------------------
// Detects format from the first 4 bytes ("FORM" / "RIFF"), scans chunks,
// streams 16384-frame blocks straight into the named Pd array. Supports
// 16/24-bit PCM, mono or stereo (mixed to mono). Returns frames written.

static uint32_t readBE32(File &f) {
    uint8_t b[4]; f.read(b, 4);
    return ((uint32_t)b[0] << 24) | ((uint32_t)b[1] << 16) |
           ((uint32_t)b[2] <<  8) |  (uint32_t)b[3];
}
static uint16_t readBE16(File &f) {
    uint8_t b[2]; f.read(b, 2);
    return ((uint16_t)b[0] << 8) | (uint16_t)b[1];
}
static uint32_t readLE32(File &f) {
    uint8_t b[4]; f.read(b, 4);
    return ((uint32_t)b[3] << 24) | ((uint32_t)b[2] << 16) |
           ((uint32_t)b[1] <<  8) |  (uint32_t)b[0];
}
static uint16_t readLE16(File &f) {
    uint8_t b[2]; f.read(b, 2);
    return ((uint16_t)b[1] << 8) | (uint16_t)b[0];
}

// IEEE-754 80-bit extended → double (AIFF sample-rate field).
static double read80BitFloat(File &f) {
    uint8_t b[10]; f.read(b, 10);
    int      exp = (((int)(b[0] & 0x7F)) << 8) | b[1];
    uint32_t hi  = ((uint32_t)b[2] << 24) | ((uint32_t)b[3] << 16) |
                   ((uint32_t)b[4] <<  8) |  (uint32_t)b[5];
    exp -= 16383 + 31;
    return (double)hi * pow(2.0, exp);
}

static int loadSample(const char* path, const char* tableName, int maxSamples) {
    File f = LittleFS.open(path, "r");
    if (!f) {
        Serial.printf("ERROR: cannot open %s\n", path);
        return 0;
    }

    char tag[4];
    f.read((uint8_t*)tag, 4);

    bool isAiff = (strncmp(tag, "FORM", 4) == 0);
    bool isWav  = (strncmp(tag, "RIFF", 4) == 0);
    if (!isAiff && !isWav) {
        Serial.printf("ERROR: %s is not AIFF (FORM) or WAV (RIFF)\n", path);
        f.close(); return 0;
    }

    isAiff ? readBE32(f) : readLE32(f);   // container size — ignored

    f.read((uint8_t*)tag, 4);
    if (isAiff && strncmp(tag, "AIFF", 4) != 0) {
        Serial.println("ERROR: FORM type is not AIFF");
        f.close(); return 0;
    }
    if (isWav && strncmp(tag, "WAVE", 4) != 0) {
        Serial.println("ERROR: RIFF type is not WAVE");
        f.close(); return 0;
    }

    int      numChannels  = 0;
    int      bitDepth     = 0;
    int      sampleFormat = 1;     // WAV fmt code: 1=PCM int, 3=IEEE float
    uint32_t numFrames    = 0;
    uint32_t dataOffset   = 0;
    bool     gotFmt       = false;
    bool     gotData      = false;

    while (f.available() >= 8) {
        f.read((uint8_t*)tag, 4);
        uint32_t chunkSize  = isAiff ? readBE32(f) : readLE32(f);
        uint32_t chunkStart = f.position();

        if (isAiff && strncmp(tag, "COMM", 4) == 0) {
            numChannels = (int)readBE16(f);
            numFrames   = readBE32(f);
            bitDepth    = (int)readBE16(f);
            double sr   = read80BitFloat(f);
            Serial.printf("[aiff] ch=%d  bits=%d  frames=%u  sr=%.0f\n",
                          numChannels, bitDepth, numFrames, sr);
            gotFmt = true;
        } else if (isAiff && strncmp(tag, "SSND", 4) == 0) {
            uint32_t ssndOff = readBE32(f);
            readBE32(f);                          // blockSize — ignored
            dataOffset = f.position() + ssndOff;
            gotData    = true;
        } else if (isWav && strncmp(tag, "fmt ", 4) == 0) {
            sampleFormat = (int)readLE16(f);
            numChannels  = (int)readLE16(f);
            uint32_t sr  = readLE32(f);
            readLE32(f);                          // byte_rate — ignored
            readLE16(f);                          // block_align — ignored
            bitDepth     = (int)readLE16(f);
            Serial.printf("[wav]  ch=%d  bits=%d  fmt=%d  sr=%u\n",
                          numChannels, bitDepth, sampleFormat, sr);
            gotFmt = true;
        } else if (isWav && strncmp(tag, "data", 4) == 0) {
            dataOffset = f.position();
            if (numChannels > 0 && bitDepth > 0) {
                numFrames = chunkSize / (numChannels * (bitDepth / 8));
            }
            gotData = true;
        }

        // chunks are word-padded to even size
        f.seek(chunkStart + chunkSize + (chunkSize & 1));
    }

    if (!gotFmt)  { Serial.println("ERROR: no fmt/COMM chunk");  f.close(); return 0; }
    if (!gotData) { Serial.println("ERROR: no data/SSND chunk"); f.close(); return 0; }
    if (bitDepth != 16 && bitDepth != 24) {
        Serial.printf("ERROR: unsupported bit depth %d (need 16 or 24)\n", bitDepth);
        f.close(); return 0;
    }
    if (numChannels < 1 || numChannels > 2) {
        Serial.printf("ERROR: unsupported channel count %d\n", numChannels);
        f.close(); return 0;
    }
    if (isWav && sampleFormat != 1) {
        Serial.printf("ERROR: only PCM WAV (fmt=1) supported, got fmt=%d\n", sampleFormat);
        f.close(); return 0;
    }

    f.seek(dataOffset);
    int frameCount = (int)min((uint32_t)maxSamples, numFrames);

    Serial.printf("[%s] %d frames (%d-bit %s, %s)\n",
                  tableName, frameCount, bitDepth, isAiff ? "AIFF" : "WAV",
                  numChannels == 2 ? "stereo→mono" : "mono");

    const int    CHUNK         = 16384;
    const int    bytesPerFrame = numChannels * (bitDepth / 8);
    const size_t rawBytes      = (size_t)CHUNK * bytesPerFrame;

    float*   chunk = (float*)  malloc(CHUNK * sizeof(float));
    uint8_t* raw   = (uint8_t*)malloc(rawBytes);
    if (!chunk || !raw) {
        Serial.println("ERROR: load buffer alloc failed");
        free(chunk); free(raw);
        f.close(); return 0;
    }

    uint32_t t0 = millis();
    int written = 0;
    while (written < frameCount) {
        int n  = min(CHUNK, frameCount - written);
        int nb = n * bytesPerFrame;
        f.read(raw, nb);

        int p = 0;
        for (int i = 0; i < n; i++) {
            float acc = 0.0f;
            for (int ch = 0; ch < numChannels; ch++) {
                int32_t s;
                if (bitDepth == 16) {
                    s = isAiff
                        ? (int16_t)(((uint16_t)raw[p] << 8) | raw[p+1])
                        : (int16_t)(((uint16_t)raw[p+1] << 8) | raw[p]);
                    p += 2;
                    acc += (float)s / 32768.0f;
                } else { // 24-bit
                    s = isAiff
                        ? (((int32_t)(int8_t)raw[p]   << 16) |
                           ((int32_t)        raw[p+1] <<  8) |
                            (int32_t)        raw[p+2])
                        : (((int32_t)(int8_t)raw[p+2] << 16) |
                           ((int32_t)        raw[p+1] <<  8) |
                            (int32_t)        raw[p]);
                    p += 3;
                    acc += (float)s / 8388608.0f;
                }
            }
            chunk[i] = (numChannels == 2) ? acc * 0.5f : acc;
        }
        Pd.writeArray(tableName, written, chunk, n);
        written += n;
    }

    uint32_t dt = max((uint32_t)1, millis() - t0);
    Serial.printf("[%s] %u ms (%u KB/s)\n",
                  tableName, dt, (uint32_t)((uint64_t)written * bytesPerFrame / dt));

    free(raw);
    free(chunk);
    f.close();
    return frameCount;
}

// ---------------------------------------------------------------------------

void setup() {
    // Wait for ESP-IDF boot logs to finish before reconfiguring UART.
    delay(2000);
    Serial.begin(115200);
    delay(200);
    Serial.println();
    Serial.println("GranularSynth — ESPdLib");

    pinMode(PIN_LED1, OUTPUT);
    digitalWrite(PIN_LED1, LOW);

    for (auto& p : pots) {
        // Clear MultiControl's startup bank-lock.
        p.mc->releaseLatch();
        // ADC EMA speed (default 0.05). Lower = smoother, higher = snappier.
        p.mc->setSnapMultiplier(0.01f);
        // Min mc-output delta before reporting a change (default 3, scale 0–1022).
        // Higher = more idle quiet, lower = catches smaller movements.
        p.mc->setPotHysteresis(24);
        // Error-EMA threshold below which the pot sleeps (default 4.0).
        // Higher = sleeps sooner, lower = wakes sooner.
        p.mc->setActivityThreshold(16.0f);
    }

    ESPdLib::Config config;
    config.sampleRate        = 44100;
    config.bclkPin           = PIN_I2S_BCLK;
    config.wsPin             = PIN_I2S_WS;
    config.doutPin           = PIN_I2S_DOUT;
    config.numOutputChannels = 1;
    config.usePSRAM          = true;
    config.psramMinAllocSize = 512;

    if (!Pd.begin(config)) {
        Serial.println("ERROR: ESPdLib init failed");
        while (1) delay(1000);
    }
    Pd.onPrint(onPdPrint);

    if (!Pd.openPatch(PATCH_FILE)) {
        Serial.println("ERROR: openPatch failed");
        while (1) delay(1000);
    }


    Serial.println();
    int nLoaded = loadSample(SAMPLE_FILE, "sample", MAX_SAMPLES);
    if (nLoaded <= 0) {
        Serial.println("ERROR: sample load failed — halting");
        while (1) delay(1000);
    }
    Serial.printf("[sample] table ready (%d samples)\n", nLoaded);

    // analogRead() before each readPot() settles the ESP32 ADC mux.
    for (auto& p : pots) {
        analogRead(p.pin);
        int raw = max(0, p.mc->readPot());
        Pd.sendFloat(p.pdName, p.scale(raw, p.minVal, p.maxVal));
    }
    Pd.sendFloat("table_size",  (float)nLoaded);
    Pd.sendFloat("sample_rate", (float)config.sampleRate);
    Pd.sendFloat("amp",         1.0f);
    Pd.sendFloat("gate",        0.0f);
}

void loop() {
    for (auto& p : pots) {
        analogRead(p.pin);
        int raw = p.mc->readPotChanged();
        if (raw >= 0) {
            float v = p.scale(raw, p.minVal, p.maxVal);
            Pd.sendFloat(p.pdName, v);
            #ifdef DEBUG
            Serial.printf("[%s] mc=%-4d  %.3f\n", p.pdName, raw, v);
            #endif
        }
    }

    btn1.readButton();
    bool pressed = btn1.isPressed();
    if (pressed && !lastBtn) {
        gate = !gate;
        Pd.sendFloat("gate", gate ? 1.0f : 0.0f);
        digitalWrite(PIN_LED1, gate);
        #ifdef DEBUG
        Serial.printf("[gate] %d\n", gate);
        #endif
    }
    lastBtn = pressed;

    Pd.processSerial();
    delay(10);
}
