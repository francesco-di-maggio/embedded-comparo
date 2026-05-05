# Adafruit ESP32 Feather V2

Three working synth sketches running on a Feather V2 with a MAX98357A I2S DAC: ring modulator, 2-operator FM, 4-voice granular. Uses the Arduino IDE.

For the platform-level context (ESPdLib, abstraction-loader patch, required libraries), see the [parent README](../README.md).

## Sketches

| Sketch | Patches | What it is |
|---|---|---|
| `pd/RingMod/` | `ring-mod.pd` | Ring modulator — carrier × modulator, gated. 3 pots + button. |
| `pd/FMSynth/` | `fm-synth.pd` | 2-operator FM synth — carrier, ratio, modulation index, gated. 3 pots + button. |
| `pd/GranularSynth/` | `granular.pd`, `grain.pd`, `granular-test.pd` | 4-voice textbook granular synthesizer reading an AIFF/WAV from LittleFS. PSRAM-backed sample table, transpose decoupled from grain rate, 4 pots + button. Desktop test patch included. |

## Hardware

Adafruit ESP32 Feather V2 — dual-core, 8 MB flash, 2 MB PSRAM.

| Component | Pin | Notes |
|---|---|---|
| MAX98357A I2S DAC | BCLK=27, LRC=33, DIN=15 | Class-D amp + speaker out. GAIN pin sets analog gain (3–15 dB). |
| Pots (ADC1) | 34, 36, 37, 39 | Input/ADC only. ADC1 stays usable while WiFi is on (ADC2 doesn't). |
| Button | 14 | Active-low, internal pull-up. |
| LED | 32 (or 13 for on-board red LED) | Digital output. |

For higher-quality audio, swap the MAX98357A for a **PCM5102** (24-bit, line-level). Same I2S pinout; `pd_audio.cpp` already sets `mclk = I2S_GPIO_UNUSED` so PCM5102 works in slave mode.

## Build & upload

Arduino IDE settings: **Tools → Board → ESP32 Feather V2**, **Tools → PSRAM → Enabled**.

For each sketch:

1. `File → Open` → select the `.ino` (e.g. `pd/GranularSynth/GranularSynth.ino`).
2. Upload the `data/` folder to LittleFS using the **ESP32 LittleFS Data Upload** tool. This puts the `.pd` patches and audio samples on the device.
3. Upload the sketch normally.

`pd/GranularSynth/data/granular-test.pd` is for desktop Pure Data — open alongside `granular.pd` to drive the synth from sliders.

## Granular synth extensions

Ideas listed in the `GranularSynth.ino` header — pick one and follow the existing pot-mapping pattern:

- `pos_jitter` / `pitch_jitter` — random scatter per grain onset (`noise~` + `samphold~`)
- `density_probability` — stochastic per-onset gate (random < threshold)
- `scan_rate` — LFO on `grain_pos` to auto-walk the sample
- `freeze` — toggle to halt scan_rate
- `reverse` — multiply step by −1
- `loop mode` — wrap vs stop at sample end
- variable window shape — switch between Hann / Gauss / triangular wndw tables
- sample switching — long-press button to cycle through `data/*.{aiff,wav}`
- stereo + per-grain pan — requires PCM5102 DAC upgrade
- OSC over WiFi — remote parameter control
