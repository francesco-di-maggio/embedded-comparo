# ESP32

Headless Pure Data on ESP32 via [ESPdLib](https://github.com/algomusic/ESPdLib), a libpd 0.56-2 wrapper. Sketches are Arduino IDE projects that load `.pd` patches from LittleFS at boot.

## Boards

- [`feather-v2/`](feather-v2/) — Adafruit ESP32 Feather V2. Primary target. Dual-core, 8 MB flash, 2 MB PSRAM.
- ESP32-C3, ESP32-C6 — planned. Single-core RISC-V, no PSRAM (granular sketch won't run without rework).

## ESPdLib

Runs Pure Data headless on ESP32 with a FreeRTOS audio task and I2S DMA, 64-sample blocks at 44.1 kHz. Patches load from LittleFS at boot. Arduino ↔ Pd communication: `Pd.sendFloat("name", v)` reaches `[r name]` in the patch; `[s name]` reaches Arduino through `Pd.subscribe()` + `Pd.onFloat()`.

**Networking objects (`[netsend]` / `[netreceive]`) are stubbed** in this libpd build — OSC must live in the Arduino sketch's `loop()`, not inside the patch.

This project's ESPdLib differs from `algomusic/ESPdLib` upstream by **one patch** that enables `.pd` abstraction loading. See [`PATCHES.md`](PATCHES.md) for the diff and drop-in files.

### Patch authoring constraints

When adapting patches for ESPdLib:

- No GUI objects (no canvas at runtime), no FFT, no externals — pure-Pd only.
- `[<~]` / `[>~]` are not creatable in this libpd build.
- Hard ceiling: ~4 abstraction instances per patch (heap/object-pool exhausts at 8 even with a 64 KB stack).
- Block size is 64 samples; receive the sample rate via `[r sample_rate]` rather than hardcoding.
- For smoothed control signals, pair `[r name]` with `[pack f 30..80]` + `[line~]`.
- LittleFS read speed caps at ~88 KB/s — long samples are slow to load. SD-over-SPI is ~5–10× faster (planned).

If you're writing your own sketch rather than adapting an existing one, set `SET_LOOP_TASK_STACK_SIZE(32 * 1024)` near the top — libpd's patch loader recurses with ~1 KB of locals per level and overflows the default 8 KB Arduino stack as soon as abstractions are involved.

## Required libraries

Install into `~/Documents/Arduino/libraries/`:

- **ESPdLib** — libpd wrapper (apply the patch above).
- **MultiControl** — pot / button / touch / encoder abstraction.
- **CNMAT OSC** — only needed once you start the WiFi/OSC route.

## Roadmap

Ordered by priority. Each is independent of the others.

### 1. WiFi + OSC control

Add WiFi + OSC parameter input to one of the sketches. Phone or desktop sends `/grain_rate 12.0` over UDP → Arduino receives → `Pd.sendFloat("grain_rate", 12.0)`. No ESPdLib changes needed (OSC must live in `loop()`, not in the patch — Pd's `[netsend]` is stubbed in this libpd build).

```cpp
#include <WiFi.h>
#include <WiFiUDP.h>
#include <OSCMessage.h>

WiFiUDP udp;
// setup(): WiFi.begin(...), udp.begin(8000)
// loop(): parse UDP packet → msg.route("/grain_rate", cb) → Pd.sendFloat()
```

### 2. WiFi patch upload

Wrap ESPdLib's existing `processSerial()` in a `WiFiServer` TCP socket. The protocol is already there — redirect bytes from a WiFi client into the same handler. ~30 lines, no library internals touched.

```
PATCH_BEGIN filename.pd
[patch text]
PATCH_END
```

Push new patches from a desktop without USB.

### 3. PCM5102 swap

Update `bclkPin/wsPin/doutPin` in the ESPdLib config struct to whatever pins you wire. `pd_audio.cpp` already sets `mclk = I2S_GPIO_UNUSED`, so the PCM5102 works in I2S slave mode. Better SNR + 24-bit + line-level out → cleaner downstream signal chain. Step up before doing serious audio work.

### 4. SD card for samples

`SD.h` over SPI. Loads larger / more samples than internal flash can hold. Reuses the AIFF/WAV streaming loader from `GranularSynth.ino` — just point it at an SD path.

```
Boot → SD.begin(csPin) → loadSample("/samples/foo.wav", "sample", MAX_SAMPLES);
```

### 5. Patch switcher

Sketch that reads a list of `.pd` files from filesystem and switches active patch via button gestures (MultiControl supports double-click and long-hold). Reference: `Arduino/libraries/ESPdLib/examples/SwitchPatches/`.
