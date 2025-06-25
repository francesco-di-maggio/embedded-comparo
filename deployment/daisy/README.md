# Daisy

Daisy supports Pd deployment via:
- [PlugData](https://plugdata.org)
- [pd2dsy](https://github.com/electro-smith/pd2dsy) (Pd to Daisy converter) – NOTE: This repository was archived by the owner on Mar 19, 2025.

- [Oopsy](https://github.com/electro-smith/oopsy) (for Max/MSP)

### Steps to Deploy a Pd Patch on Daisy Pod

1. **Install Toolchain**  
   Follow the [Daisy Getting Started Guide](https://github.com/electro-smith/DaisyWiki/wiki/Getting-Started).

2. **Prepare the Patch**  
   Map controls using Daisy's namespace. Example:
   ```
   r Knob1 @hv_param
   ```

3. **Upload and Compile**  
   Daisy must be in DFU mode.
   - **PlugData Export**: Directly generate firmware
   - [**Daisy Web Programmer**](https://electro-smith.github.io/Programmer/): Upload and flash via browser

📎 Daisy Wiki: [https://github.com/electro-smith/DaisyWiki](https://github.com/electro-smith/DaisyWiki)
