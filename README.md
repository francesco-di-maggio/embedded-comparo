# Embedded Comparo

A comparative reference for embedded audio DSP — platforms × languages.

---

## Introduction

Embedded systems have become vital for digital musical instrument design and interactive audio projects. However, deploying audio DSP patches across various hardware platforms often involves complex and inconsistent workflows, fragmented documentation, and one-off toolchains.

This project addresses that fragmentation by collecting **comparative deployment workflows** under one roof, across both hardware platforms (e.g., Bela, Daisy, OWL, Raspberry Pi) and audio programming languages (e.g., Pure Data, Max/gen~ and RNBO). Pure Data is the current default. Max/gen~, RNBO, FAUST, and SuperCollider are on the roadmap, with coverage varying per platform.

Our aim is to lower the barrier to picking a target, switching between them, and contributing new ones, promoting broader adoption, exploration, and collaboration amongst researchers, musicians, and educators.

---

## Deployment Directory

Layout follows `deployment/<platform>/<board>/<language>/`. The `deployment/` directory contains subfolders for each target platform, each offering a complete set of audio patches and platform-specific abstractions. The implementations follow a shared methodology emphasizing portability, abstraction, and minimal patch modification between systems.

## Pure Data Patches

Each board's `pd/` directory contains a set of patch folders. Each patch folder holds `_main.pd` (the entry patch) plus any supporting abstractions.

### Hardware-Specific Details

* **Bela** — supports both native and hvcc-compiled Pd modes. Compatible with the Bela Pepper Eurorack interface.
* **Daisy** — requires compilation with Plugdata or `pd2dsy` using the Heavy compiler. Tested on Daisy Pod and Daisy Field.
* **OWL** — compiled online via the OWL Web IDE using the Heavy compiler. Mappings must follow the OWL Pd namespace.
* **Raspberry Pi** — runs Pd natively under Linux. Tested with Organelle M (based on Pi Compute Module 3+) and supports real-time patching with GUI.

See each subfolder's README for specific deployment steps.

---

## Software-Specific Details

* **Pure Data** — native or Heavy-compiled across all current platforms
* **Max / gen~** — Cycling '74 environment, with RNBO export to supported hardware
* **RNBO** — C++ export targeting Bela and Raspberry Pi
* **FAUST** — compiles to nearly every target included here
* **SuperCollider** — for Raspberry Pi-class targets

See the per-platform README for the current status.

---

## Getting Started

Detailed deployment instructions for each platform live in the respective folders or in the [deployment/](./deployment/) directory.

### Pure Data

To test a patch in Pure Data:

1. Start with the board's `template-<board>` to verify hardware input/output mapping.
2. Open `_main.pd` from the chosen patch folder (e.g. `fm/_main.pd`) in your platform's IDE.
3. Follow the build or compilation steps detailed for Bela, Daisy, OWL, or Raspberry Pi.
4. Raspberry Pi runs Pd natively, or via Patchbox OS.

---

## Contributing

Community contributions to this project are welcome.

You can contribute by:

* Improving existing patches
* Porting patches to additional platforms or languages
* Optimizing deployment workflows
* Adding examples from other audio programming languages (FAUST, RNBO, gen~, SuperCollider)

### How to Contribute

1. Fork the repository
2. Create your branch
3. Submit a pull request with a clear description of your contribution

Please review our [CONTRIBUTING.md](./CONTRIBUTING.md) before submitting your work.

---

## Future Work

Planned future developments include:

* More boards: ESP32, Teensy 4, RP2040, STM32
* Broader language coverage: Max/gen~, RNBO, FAUST, and SuperCollider examples
* Enhanced modular abstractions for filtering, CV/MIDI integration, and beyond
* Improved compatibility of advanced patches on microcontrollers
* Detailed example performance setups

We welcome your suggestions and feedback to help guide these developments.

---

## Useful Links

### Hardware Platforms

* [Bela](https://bela.io)
* [Daisy](https://electro-smith.com/daisy)
* [OWL](https://www.rebeltech.org/product/owl/)
* [Raspberry Pi](https://www.raspberrypi.com)
* [Organelle](https://www.critterandguitari.com/organelle)

### Audio Programming Languages

* [Pure Data](https://puredata.info)
* [Plugdata](https://plugdata.org)
* [Max / gen~](https://cycling74.com/products/max)
* [RNBO](https://rnbo.cycling74.com)
* [FAUST](https://faust.grame.fr)
* [SuperCollider](https://supercollider.github.io)

### Libraries & Tools
* [Heavy Compiler Collection (hvcc)](https://wasted-audio.github.io/hvcc/)

---

## Origin & Citation

This repository accompanies our NIME 2025 paper [*Embedded Comparo: Small DSP Systems Side-by-Side*](https://nime.org/proceedings/2025/nime2025_72.pdf), which compares four platforms running Pure Data: Bela, Daisy, OWL, and Raspberry Pi. The publication snapshot is preserved as [**v1.0**](https://github.com/francesco-di-maggio/embedded-comparo/releases/tag/v1.0). Subsequent versions broaden the project into an ongoing comparison of small DSP systems.

Please cite our work if you use this repository and paper in your research:

```
Di Maggio, F. et al. (2025). Embedded Comparo: Small DSP Systems Side-by-Side.
Proceedings of the International Conference on New Interfaces for Musical Expression,
NIME '25, June 24–27, 2025, Canberra, Australia.
```

<p align="left">
  <img alt="NIME'25 - A0 Poster Presentation" src="https://github.com/user-attachments/assets/b87e2694-af1f-45d0-80a9-f940cdb1e159" width="100%">
</p>

---

## License

[**MIT License**](LICENSE)