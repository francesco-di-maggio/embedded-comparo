# Deployment Methods

This directory documents how to deploy patches to various embedded audio platforms — primarily Pure Data, with other languages (Max/gen~, RNBO, FAUST, SuperCollider) as coverage expands.

Each platform requires its own specific tools and setup process. See the subdirectories for detailed, step-by-step instructions:

- [Bela](./bela/README.md)
- [Daisy](./daisy/README.md)
- [ESP32](./esp/README.md)
- [OWL](./owl/README.md)
- [Raspberry Pi (Organelle)](./pi/README.md)

---

## About the Heavy Compiler

To compile Pd patches for Daisy and OWL, we use the [**Heavy Compiler (hvcc)**](https://github.com/enzienaudio/heavy).

Heavy analyzes Pd patches and translates their signal processing components into highly optimized C++ code. This offers several advantages:

- Reduces CPU load and memory overhead.
- Compiles the patch into standalone DSP code.
- Improves CPU efficiency, latency, and resource management.
