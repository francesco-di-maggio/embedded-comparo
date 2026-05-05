/*
 * RingMod — ESPdLib example
 *
 * Ring modulator. Carrier and modulator oscillators multiply together,
 * producing sum and difference frequencies.
 *
 * Signal flow:
 *   [r carrier]   -> [pack f 80] -> [line~] -> [osc~] -> [*~] -> [*~ amp] -> [*~ gate] -> [hip~ 5] -> [clip~ -1 1] -> [dac~]
 *   [r modulator] -> [pack f 80] -> [line~] -> [osc~] ----^
 *   [r amp]       -> [pack f 80] -> [line~] ------------------------^
 *   [r gate]      -> gate envelope (50 ms attack / 300 ms release)
 *
 * Hardware (Adafruit ESP32 Feather V2 + MAX98357A I2S DAC):
 *   I2S       BCLK=27, LRC=33, DIN=15
 *   pot1      GPIO36 -> carrier    (55–880 Hz, exp)
 *   pot2      GPIO39 -> modulator  (1–110 Hz, exp)
 *   pot3      GPIO34 -> amp        (0.0–0.75, lin)
 *   pot4      GPIO37 -> (unused in this sketch)
 *   but1      GPIO14 -> gate toggle
 *   led1      GPIO32 -> gate indicator
 *
 * Upload data/ to LittleFS before flashing.
 */

#include <ESPdLib.h>
#include <MultiControl.h>

#define DEBUG  // comment out to silence per-control prints

// --- Pins ---
#define PIN_POT1     36
#define PIN_POT2     39
#define PIN_POT3     34
#define PIN_BUT1     14
#define PIN_LED1     32

// --- I2S (MAX98357A) ---
#define PIN_I2S_BCLK 27
#define PIN_I2S_WS   33
#define PIN_I2S_DOUT 15

// --- Pd patch ---
#define PATCH_FILE   "ring-mod.pd"

// --- Pot calibration (MultiControl output, 0–1022 scale) ---
// If readings don't reach 0/1022, raise POT_MIN / lower POT_MAX accordingly.
#define POT_MIN     0.0f
#define POT_MAX  1022.0f

// MultiControl ctor: type 1 = potentiometer, 2 = button.
MultiControl pot1(PIN_POT1, 1);
MultiControl pot2(PIN_POT2, 1);
MultiControl pot3(PIN_POT3, 1);
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
    { &pot1, PIN_POT1, "carrier",   55.0f, 880.0f, scaleExp },
    { &pot2, PIN_POT2, "modulator",  1.0f, 110.0f, scaleExp },
    { &pot3, PIN_POT3, "amp",        0.0f,  0.75f, scaleLin },
};

void setup() {
    // Wait for ESP-IDF boot logs to finish before reconfiguring UART.
    delay(2000);
    Serial.begin(115200);
    delay(200);
    Serial.println();
    Serial.println("RingMod — ESPdLib");

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

    if (!Pd.begin(config)) {
        Serial.println("ERROR: ESPdLib init failed");
        while (1) delay(1000);
    }
    Pd.onPrint(onPdPrint);

    if (!Pd.openPatch(PATCH_FILE)) {
        Serial.println("ERROR: openPatch failed");
        while (1) delay(1000);
    }

    // analogRead() before each readPot() settles the ESP32 ADC mux.
    for (auto& p : pots) {
        analogRead(p.pin);
        int raw = max(0, p.mc->readPot());
        Pd.sendFloat(p.pdName, p.scale(raw, p.minVal, p.maxVal));
    }
    Pd.sendFloat("gate", 0.0f);
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
