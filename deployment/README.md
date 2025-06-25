# Deployment Methods

The deployment process for Pd patches varies depending on the platform. Below is an overview of supported platforms and methods:

## Bela

Bela allows Pd patches to be deployed in two main ways:

- **Browser-Based IDE**: Bela provides its own interactive development environment (IDE) that allows users to upload and run Pd patches directly from a browser.
- **Heavy Compiler (hvcc)**: Pd patches can be compiled into optimized C++ code using the Heavy Compiler for improved performance.

## Daisy

Daisy supports Pd patch deployment through the following tools:

- **PlugData**: A user-friendly visual editor that supports exporting Pd patches directly to Daisy-compatible firmware.
- **pd2dsy**: A Pd-to-Daisy conversion tool that compiles patches using the Heavy Compiler and packages them for flashing onto Daisy hardware.

## OWL (OpenWareLab)

OWL runs the Heavy Compiler in the cloud and allows Pd patches to be deployed via its:

- **Web IDE**: A browser-based environment where users can upload Pd patches, compile them in the cloud using Heavy, and flash them directly to OWL devices.

## Organelle

The Organelle runs Pure Data natively, making deployment very straightforward:

- **Native Pd Execution**: Pd patches can be transferred directly to the device.
- **Wi-Fi Connectivity**: The file system is accessible over the local network, allowing users to upload and manage patches wirelessly.

---

## About the Heavy Compiler

To compile our Pd patches for Daisy and OWL, we used the **Heavy Compiler (hvcc)**.

Heavy analyzes Pd patches and translates their signal processing components into highly optimized C++ code. This offers several advantages:

- Reduces CPU load and memory overhead.
- Compiles the patch into standalone DSP code.
- Improves CPU efficiency, latency, and resource management.

Heavy is a powerful tool for turning Pd patches into efficient, production-ready firmware across multiple embedded audio platforms.
