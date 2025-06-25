# Deployment Methods

This directory documents how to deploy Pure Data (Pd) patches to various embedded audio platforms.

Each platform requires its own specific tools and setup process. See the subdirectories for detailed, step-by-step instructions:

- [Bela](./bela/README.md)
- [Daisy](./daisy/README.md)
- [OWL](./owl/README.md)
- [Organelle](./organelle/README.md)

---

## About the Heavy Compiler

To compile our Pd patches for Daisy and OWL, we used the [**Heavy Compiler (hvcc)**](https://github.com/enzienaudio/heavy).

Heavy analyzes Pd patches and translates their signal processing components into highly optimized C++ code. This offers several advantages:

- Reduces CPU load and memory overhead.
- Compiles the patch into standalone DSP code.
- Improves CPU efficiency, latency, and resource management.
