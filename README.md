# NEORV32 RISC-V Softcore with Ada HAL

> **Note:** This is a fork of [stnolting/neorv32-setups](https://github.com/stnolting/neorv32-setups) with curated instructions and repository structure optimized for Ada firmware development with [neorv32-hal](https://github.com/GNAT-Academic-Program/neorv32_hal). The original repository contains setups for many more FPGA boards.

This repository provides FPGA setups for the [NEORV32 RISC-V Processor](https://github.com/stnolting/neorv32) with Ada firmware support through neorv32-hal (included as a submodule).

## Supported FPGA Boards

This guide covers three development boards:

| Board | FPGA | Toolchain | Setup Location |
|:------|:-----|:----------|:---------------|
| [Digilent Basys3](https://reference.digilentinc.com/reference/programmable-logic/basys-3/reference-manual) | Xilinx Artix-7 `XC7A35TCPG236-1` | Vivado | [`vivado/basys3-a7-test-setup`](vivado/basys3-a7-test-setup) |
| [ULX3S](https://radiona.org/ulx3s/) | Lattice ECP5 `LFE5U-85F` | Open Source (GHDL/Yosys/nextPNR) | [`osflow`](osflow) |
| [Sipeed Tang Nano 9K](https://wiki.sipeed.com/hardware/en/tang/Tang-Nano-9K/Nano-9K.html) | Gowin GW1NR-9 `GW1NR-LV9QN88PC6/I5` | Gowin EDA | [`gowineda/tang-nano-9k`](gowineda/tang-nano-9k) |

---

## Getting Started

> **Important:** This repository uses Git submodules. You **must** clone with submodules to get the complete project.

**Clone this repository with submodules:**

```bash
git clone --recurse-submodules https://github.com/GNAT-Academic-Program/neorv32-setups.git
cd neorv32-setups
```
---

## Building the Softcore

| Setup | Toolchain | Board | FPGA | Author(s) |
|:------|:----------|:------|:-----|:----------|
| :file_folder: [`de0-nano-test-setup`](https://github.com/stnolting/neorv32-setups/tree/main/quartus/de0-nano-test-setup) | Intel Quartus Prime | [Terasic DE0-Nano](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=139&No=593)                     | Intel Cyclone IV `EP4CE22F17C6N`          | [stnolting](https://github.com/stnolting) |
| :file_folder: [`de10-nano-test-setup`](https://github.com/stnolting/neorv32-setups/tree/main/quartus/de10-nano-test-setup) | Intel Quartus Prime | [Terasic DE10-Nano](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=167&No=1046#contents)                     | Intel Cyclone V `5CSEBA6U23I7`          | [provoostkris](https://github.com/provoostkris) |
| :file_folder: [`de0-nano-test-setup-qsys`](quartus/de0-nano-test-setup-qsys) | Intel Quartus Prime | [Terasic DE0-Nano](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=139&No=593)                     | Intel Cyclone IV `EP4CE22F17C6N`          | [torerams](https://github.com/torerams) |
| :file_folder: [`de0-nano-test-setup-avalonmm`](quartus/de0-nano-test-setup-avalonmm-wrapper) | Intel Quartus Prime | [Terasic DE0-Nano](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=139&No=593)                     | Intel Cyclone IV `EP4CE22F17C6N`          | [torerams](https://github.com/torerams) |
| :file_folder: [`terasic-cyclone-V-gx-starter-kit-test-setup`](https://github.com/stnolting/neorv32-setups/tree/main/quartus/terasic-cyclone-V-gx-starter-kit-test-setup) | Intel Quartus Prime | [Terasic Cyclone-V GX Starter Kit](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=167&No=830) | Intel Cyclone V `5CGXFC5C6F27C7N` | zs6mue |
| :file_folder: [`UPduino_v3`](https://github.com/stnolting/neorv32-setups/tree/main/radiant/UPduino_v3)                   | Lattice Radiant     | [tinyVision.ai Inc. UPduino `v3.0`](https://www.tindie.com/products/tinyvision_ai/upduino-v30-low-cost-lattice-ice40-fpga-board/) | Lattice iCE40 UltraPlus `iCE40UP5K-SG48I` | [stnolting](https://github.com/stnolting) |
| :file_folder: [`iCEBreaker`](https://github.com/stnolting/neorv32-setups/tree/main/radiant/iCEBreaker)                   | Lattice Radiant     | [iCEBreaker @ GitHub](https://github.com/icebreaker-fpga/icebreaker)                                                              | Lattice iCE40 UltraPlus `iCE40UP5K-SG48I` | [stnolting](https://github.com/stnolting) |
| :file_folder: [`arty-a7-35-test-setup`](https://github.com/stnolting/neorv32-setups/tree/main/vivado/arty-a7-test-setup) | Xilinx Vivado       | [Digilent Arty A7-35](https://reference.digilentinc.com/reference/programmable-logic/arty-a7/start)                               | Xilinx Artix-7 `XC7A35TICSG324-1L`        | [stnolting](https://github.com/stnolting) |
| :file_folder: [`basys3-a7-test-setup`](vivado/basys3-a7-test-setup) | Xilinx Vivado       | [Digilent Basys3](https://digilent.com/reference/programmable-logic/basys-3/start)                               | Xilinx Artix-7 `XC7A35TCPG236-1`        | [ohenley](https://github.com/ohenley) |
| :file_folder: [`nexys-a7-test-setup`](https://github.com/stnolting/neorv32-setups/tree/main/vivado/nexys-a7-test-setup)  | Xilinx Vivado       | [Digilent Nexys A7](https://reference.digilentinc.com/reference/programmable-logic/nexys-a7/start)                                | Xilinx Artix-7 `XC7A50TCSG324-1`          | [AWenzel83](https://github.com/AWenzel83) |
| :file_folder: [`nexys-a7-test-setup`](https://github.com/stnolting/neorv32-setups/tree/main/vivado/nexys-a7-test-setup)  | Xilinx Vivado       | [Digilent Nexys 4 DDR](https://reference.digilentinc.com/reference/programmable-logic/nexys-4-ddr/start)                          | Xilinx Artix-7 `XC7A100TCSG324-1`         | [AWenzel83](https://github.com/AWenzel83) |
| :file_folder: [`z7-nano-test-setup`](https://github.com/stnolting/neorv32-setups/tree/main/vivado/z7-nano-test-setup)  | Xilinx Vivado       | [Microphase Z7 Nano FPGA Board](https://github.com/MicroPhase/fpga-docs/blob/master/schematic/Z7-NANO_R21.pdf)                              | Xilinx ZynQ 7000 `c7z020clg400-2`        | [provoostkris](https://github.com/provoostkris) |
| :file_folder: [`on-chip-debugger-intel`](https://github.com/stnolting/neorv32-setups/tree/main/quartus/on-chip-debugger-intel) | Intel Quartus Prime | [Gecko4Education](https://gecko-wiki.ti.bfh.ch/gecko4education:start)                                                       | Intel Cyclone IV E `EP4CE15F23C8`         | [NikLeberg](https://github.com/NikLeberg) |
| :file_folder: [`tang-nano-9k`](https://github.com/stnolting/neorv32-setups/tree/main/gowineda/tang-nano-9k)              | Gowin EDA           | [Sipeed Tang Nano 9K](https://wiki.sipeed.com/hardware/en/tang/Tang-Nano-9K/Nano-9K.html)                                         | Gowin LittleBee GW1NR-9 `GW1NR-LV9QN88PC6/I5` | [IvanVeloz](https://github.com/IvanVeloz)
| :file_folder: [`tang-nano-20k`](https://github.com/stnolting/neorv32-setups/tree/main/gowineda/tang-nano-20k)              | Gowin EDA           | [Sipeed Tang Nano 20K](https://wiki.sipeed.com/hardware/en/tang/tang-nano-20k/nano-20k.html)                                         | Gowin Morningside GW2A-18 `GW2AR-LV18QN88C8/I7` | [duvitech-llc](https://github.com/duvitech-llc)
=======
### Option 1: Digilent Basys3 (Xilinx Vivado)

**Prerequisites:** Xilinx Vivado installed

1. Navigate to the Basys3 setup directory:
   ```bash
   cd vivado/basys3-a7-test-setup
   ```

2. Generate the bitstream:
   ```bash
   vivado -mode batch -source create_project.tcl
   ```

3. Program the FPGA:
   ```bash
   vivado -mode batch -source program_bitstream.tcl
   ```

4. Connect via UART at **19200 baud, 8N1** (USB-UART appears as `/dev/ttyUSB0` or `COM*` on Windows)

See [vivado/basys3-a7-test-setup/README.md](vivado/basys3-a7-test-setup/README.md) for details.

---

### Option 2: ULX3S (Open Source Toolchain)

**Prerequisites:** Docker installed

1. **Pull the neorv32/impl container** (includes GHDL, Yosys, nextPNR):
   ```bash
   docker pull ghcr.io/stnolting/neorv32/impl:latest
   ```

2. **Run the container:**
   ```bash
   docker run --rm -it -v "$(pwd)":/workspace ghcr.io/stnolting/neorv32/impl bash
   cd /workspace
   ```

3. **Build the bitstream:**
   ```bash
   cd osflow
   make BOARD=ULX3S MinimalBoot
   ```

4. **Program the board using fujprog:**
   ```bash
   fujprog neorv32_ULX3S_MinimalBoot.bit
   ```

See [osflow/README.md](osflow/README.md) for more targets and details.

---

### Option 3: Tang Nano 9K (Gowin EDA)

**Prerequisites:** Gowin EDA installed

1. Navigate to the Tang Nano 9K setup directory:
   ```bash
   cd gowineda/tang-nano-9k
   ```

2. Open the project in Gowin EDA IDE

3. Generate and program the bitstream using Gowin Programmer

See [gowineda/tang-nano-9k/README.md](gowineda/tang-nano-9k/README.md) for details.

---

## Building Ada Firmware

### Prerequisites

1. **Install Alire** (Ada package manager): [alire.ada.dev](https://alire.ada.dev/)
   
2. **Ensure RISC-V toolchain is in PATH** (installed automatically by Alire):
   
   **Linux/macOS:**
   ```bash
   export PATH="$PATH:~/.local/share/alire/toolchains/gnat_riscv64_elf_*/bin"
   ```
   Add to `~/.bashrc` or `~/.zshrc` to make permanent.
   
   **Windows (PowerShell):**
   ```powershell
   $env:PATH += ";$env:USERPROFILE\.local\share\alire\toolchains\gnat_riscv64_elf_*\bin"
   ```
   Add to PowerShell profile or set permanently via System Environment Variables.

3. **Build and install the bootloader image generator:**
   
   **Linux/macOS:**
   ```bash
   cd neorv32/sw/image_gen
   gcc image_gen.c -o image_gen
   sudo cp image_gen /usr/local/bin/
   ```
   
   **Windows (PowerShell/CMD):**
   ```cmd
   cd neorv32\sw\image_gen
   gcc image_gen.c -o image_gen.exe
   ```
   Then manually copy `image_gen.exe` to a directory in your PATH (e.g., `C:\Windows\System32`) or add the current directory to your PATH.


### Build the Demo Firmware

The neorv32-hal repository is already included as a submodule in this fork.

1. **Navigate to the demos directory:**
   ```bash
   cd neorv32-hal/demos
   ```

2. **Build the firmware using the provided scripts:**

   **For application binary (to upload via bootloader):**
   
   **Linux/macOS:**
   ```bash
   ./build_app_bin.sh
   ```
   
   **Windows:**
   ```batch
   build_app_bin.bat
   ```
   
   This script builds the Ada firmware with Alire and converts it to the NEORV32 executable format (`bin/bios.exe`) that can be uploaded via the bootloader.

   **For bootloader VHDL image (to synthesize into bitstream):**
   
   1. **Edit the linker script** `neorv32-hal/src/link.ld`:
      
      Change the ROM origin from:
      ```
      rom (rx) : ORIGIN = 0x0, LENGTH = 0x10000
      ```
      
      To:
      ```
      rom (rx) : ORIGIN = 0xFFE00000, LENGTH = 0x10000
      ```
   
   2. **Run the build script:**
      
      **Linux/macOS:**
      ```bash
      ./build_bld_vhd.sh
      ```
      
      **Windows:**
      ```batch
      build_bld_vhd.bat
      ```
   
   This script builds the Ada firmware and generates a VHDL file (`neorv32/rtl/core/neorv32_bootloader_image.vhd`) that will be synthesized directly into the FPGA bitstream as the bootloader ROM.

### Upload Firmware to FPGA

#### Linux

1. **Install gtkterm:**
   ```bash
   sudo apt install gtkterm
   ```

2. **Connect to bootloader:**
   ```bash
   gtkterm --port /dev/ttyUSB0 --speed 19200
   ```
   Set `CR LF auto` in Configuration menu.

3. **Upload firmware:**
   - Type `u` at `CMD:>` prompt
   - Press **Ctrl+Shift+R** and select `bin/bios.exe`
   - After upload completes, type `e` to execute

#### Windows

1. **Install Tera Term:** Download from [teratermproject.github.io](https://teratermproject.github.io/)

2. **Connect to bootloader:**
   - Open Tera Term
   - Select your COM port (e.g., COM3)
   - Set speed to **19200 baud, 8N1**
   - Go to Setup → Terminal → Set "New-line" to "Receive: AUTO" and "Transmit: CR+LF"

3. **Upload firmware:**
   - Type `u` at `CMD:>` prompt
   - Go to File → Transfer → XMODEM → Send
   - Select `bin\bios.exe`
   - After upload completes, type `e` to execute

---

## Using neorv32_hal in Your Ada Projects

For information on integrating neorv32_hal into your own Ada projects, see the [neorv32-hal README](neorv32-hal/README.md).

---

## Additional Resources

- [NEORV32 Documentation](https://stnolting.github.io/neorv32/)
- [neorv32-hal Repository](https://github.com/GNAT-Academic-Program/neorv32_hal)
- [Ada Blog Post: Open Source Ada from Gateware to Application](https://blog.adacore.com/open-source-ada-from-gateware-to-application)
- [NEORV32 User Guide](https://stnolting.github.io/neorv32/ug/)
- [Original neorv32-setups Repository](https://github.com/stnolting/neorv32-setups)

## License

See [LICENSE](LICENSE) for details.
