# Bela Pepper

Bela supports two modes of Pd deployment:
- **libpd mode**: Runs Pd patches using Bela’s browser IDE, compiled to run via `libpd`.
- **Heavy mode**: Compiles Pd patches into C++ using `hvcc`.

### Steps to Deploy a Pd Patch on Bela Pepper

1. **Prepare the Patch**  
   Map ADC/DAC to hardware controls:
   - Inputs: ADCs 3–10
   - Outputs: DACs 3–10

2. **Upload via Web IDE**  
   - Access: [http://bela.local](http://bela.local)
   - Create a new project → Choose "Pure Data"
   - Upload your patch as `_main.pd`

3. **Compile and Run**  
   Click **Run** in the IDE. The patch is compiled and executed using `libpd`.

📎 Docs: [https://learn.bela.io](https://learn.bela.io)
