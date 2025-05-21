# Embedded Comparo: Small DSP Systems Side-by-Side

## NIME 2025 | June 24–27, Canberra, Australia

Welcome to the official repository accompanying our publication: **"Embedded Comparo: Small DSP Systems Side-by-Side"** presented at NIME 2025. This repository provides comprehensive documentation and resources for deploying real-time audio patches using **Pure Data (Pd)** across four embedded platforms: **Bela**, **Daisy**, **OWL**, and **Raspberry Pi**.

<p align="left">
  <img alt="teaser" src="![teaser-NIME25](https://github.com/user-attachments/assets/8629600a-b368-4c10-9982-a071cd52097f)" width="765">
</p>

---

## Introduction

Embedded systems have become vital for digital musical instrument design and interactive audio projects. However, deploying audio DSP patches across various hardware platforms often involves complex and inconsistent workflows. This project addresses this challenge by providing comparative insights and unified Pure Data deployment workflows across four widely-used platforms.

Our aim is to simplify the process for musicians, researchers, educators, and developers, facilitating broader adoption and easier collaboration.

---

## Repository Structure

Each platform folder contains:

* A `template.pd` file with hardware-specific configurations
* Pure Data patches:

  * `fm.pd`: Simple FM synthesis
  * `granular.pd`: Granular synthesis
  * `cloud_generator.pd`: Real-time granular generator

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

We are continuously updating this repository with additional images, diagrams, and future video tutorials. 

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

Di Maggio, F. et al. (2025). *Embedded Comparo: Small DSP Systems Side-by-Side*. Proceedings of the International Conference on New Interfaces for Musical Expression (NIME).

---

## License

This project is licensed under the [**MIT License**](LICENSE.md).

---

## Useful Links

* [Our NIME 2025 Paper](#)
* [Poster Presentation](#)
* [Pure Data official website](https://puredata.info)
* [Plugdata](https://plugdata.org)
* [Bela Platform](https://bela.io)
* [Daisy Platform](https://electro-smith.com/daisy)
* [OWL Platform](https://www.rebeltech.org/product/owl/)
* [Raspberry Pi](https://www.raspberrypi.com)
* [Organelle](https://www.critterandguitari.com/organelle)

---

## Contact

For questions, collaboration, or feedback:

* GitHub Issues
* Email: \[[f.di.maggio@tue.nl](mailto:f.di.maggio@tue.nl)]
* Project page: [https://github.com/francesco-di-maggio/embedded-comparo](https://github.com/yourname/embedded-comparo)
