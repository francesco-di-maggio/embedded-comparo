# OWL

OWL Lich uses a cloud-based IDE to compile and upload Pd patches via the [Heavy Compiler (hvcc)](https://github.com/enzienaudio/heavy).

### Steps to Deploy a Pd Patch on OWL Lich

1. **Prepare the Patch**  
   Use OWL namespace mappings:
   ```
   r Button_1 @owl B1
   ```

2. **Create Account**  
   Register at [https://www.rebeltech.org/myaccount](https://www.rebeltech.org/myaccount)

3. **Upload Patch**
   - Go to: Patches → My Patches → Create new patch
   - Upload `.pd` file or use GitHub link

4. **Compile and Connect**
   - Click: Device → Connect to Device (recognized via USB-MIDI)

5. **Load to OWL**
   - Use [OwlControl](https://github.com/pingdynasty/OwlControl) or direct flashing

📎 OWL Patch Library: [https://www.rebeltech.org/patch-library/](https://www.rebeltech.org/patch-library/)
