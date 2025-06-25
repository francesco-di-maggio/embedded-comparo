# Embedded Comparo: Small DSP Systems Side-by-Side

## NIME 2025 | June 24–27, Canberra, Australia

Welcome to the official repository accompanying our publication: [**Embedded Comparo: Small DSP Systems Side-by-Side**](https://nime.org/proceedings/2025/nime2025_72.pdf) presented at NIME 2025. This repository provides (work-in-progress) documentation and resources for deploying real-time audio patches using **Pure Data (Pd)** across four embedded platforms: **Bela**, **Daisy**, **OWL**, and **Raspberry Pi**.

<p align="left">
  <img alt="NIME'25 - A0 Poster Presentation" src="https://github.com/user-attachments/assets/b87e2694-af1f-45d0-80a9-f940cdb1e159" width="100%">
</p>

---

## Introduction

Embedded systems have become vital for digital musical instrument design and interactive audio projects. However, deploying audio DSP patches across various hardware platforms often involves complex and inconsistent workflows. This project addresses this challenge by providing comparative insights and unified Pure Data deployment workflows across four widely-used platforms.

Our aim is to simplify the process for musicians, researchers, educators, and developers, promoting broader adoption and collaboration.

---

## Repository Structure

```
.
├── README.md                  # Main project overview
├── deployment/                # Deployment documentation and step-by-step guides
│   ├── bela/                  # Bela platform documentation
│   │   └── pepper/            # Bela Pepper-specific setup
│   │       └── pd/            # Pd patches for Bela Pepper
│   ├── daisy/                 # Daisy platform documentation
│   │   └── pod/               # Daisy Pod-specific setup
│   │       └── pd/            # Pd patches for Daisy Pod
│   ├── owl/                   # OWL platform documentation
│   │   └── lich/              # OWL Lich-specific setup
│   │       └── pd/            # Pd patches for OWL Pod
│   └── rpi/                   # Raspberry Pi platform (Organelle) documentation
│       └── organelle/         # Organelle-specific setup
│           └── pd/            # Pd patches for Organelle
└──
```

---

## Deployment Directory

The `deployment/` directory contains subfolders for each target platform, each offering a complete set of Pure Data patches and platform-specific abstractions. These implementations are based on our study’s methodology, which emphasizes portability, abstraction, and minimal patch modification between systems.

Each platform subdirectory contains:

* **`template.pd`**: a core abstraction for control and I/O mapping tailored to that hardware
* **`fm.pd`**: a simple FM synthesizer used for baseline audio deployment
* **`granular.pd`**: a multi-voice granular sampler based on buffer playback
* **`cloud_generator.pd`**: a real-time granular processor using audio input and dynamic voice instantiation

All patches follow a common patching structure with a modular control abstraction, enabling easier adaptation between targets.

### Platform-Specific Details:

* **Bela**: Supports both native and hvcc-compiled Pd modes. Compatible with Bela Pepper Eurorack interface.
* **Daisy**: Requires compilation with Plugdata or `pd2dsy` using the Heavy compiler. Tested on Daisy Pod and Daisy Patch.Init.
* **OWL**: Compiled online via the OWL Web IDE using the Heavy compiler. Mappings must follow the OWL Pd namespace.
* **Raspberry Pi**: Runs Pd natively under Linux. Tested with Organelle M (based on Pi Compute Module 3+) and supports real-time patching with GUI.

See each subfolder README or the `docs/` directory for specific deployment steps.

---

## Getting Started

Detailed deployment instructions for each platform can be found in the respective folders or in the [deployment/](./deployment/) directory.

To test a patch:

1. Begin with the `template.pd` and ensure hardware input/output is correctly mapped.
2. Load your chosen main patch (e.g., `fm.pd`) into your platform's IDE.
3. Follow specific build or compilation steps detailed for Bela, Daisy, and OWL.
4. Raspberry Pi users can run patches natively or via Patchbox OS.

---

## Documentation and Tutorials

We are continuously updating this repository with additional images, diagrams, and future video tutorials. Contributions from the community to expand documentation are highly encouraged.

---

## Contributing

Community contributions to this project are welcome!

You can contribute by:

* Improving existing patches
* Porting patches to additional platforms
* Optimizing deployment workflows
* Adding examples from other audio programming languages (FAUST, RNBO, gen\~)

### How to Contribute

1. Fork the repository
2. Create your branch
3. Submit a pull request with a clear description of your contribution

Please review our [CONTRIBUTING.md](./CONTRIBUTING.md) before submitting your work.

---

## Future Work

Planned future developments include:

* Enhanced modular Pure Data abstractions for integration with filtering, CV/MIDI and such
* Improved compatibility of advanced patches on microcontrollers
* Deployment instructions and examples for **RNBO**, **FAUST**, and **SuperCollider**
* Detailed example performance setups

We welcome your suggestions and feedback to help guide these developments.

---

## Citation

Please cite our work if you use this repository in your research:

```
Di Maggio, F. et al. (2025). Embedded Comparo: Small DSP Systems Side-by-Side. Proceedings of the International Conference on New Interfaces for Musical Expression, NIME ’25, June 24–27, 2025, Canberra, Australia.
```

---

## License

This project is licensed under the [**MIT License**](LICENSE.md).

---

## Useful Links

* [Pure Data](https://puredata.info)
* [Plugdata](https://plugdata.org)
* [Bela](https://bela.io)
* [Daisy](https://electro-smith.com/daisy)
* [OWL](https://www.rebeltech.org/product/owl/)
* [Raspberry Pi](https://www.raspberrypi.com)
* [Organelle](https://www.critterandguitari.com/organelle)

---

## Contact

For questions, collaboration, or feedback:

* GitHub Issues
* Email: [f.di.maggio@tue.nl](mailto:f.di.maggio@tue.nl)
* Project page: [https://github.com/francesco-di-maggio/embedded-comparo](https://github.com/yourname/embedded-comparo)
