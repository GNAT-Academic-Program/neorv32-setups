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

**If you already cloned without submodules, initialize them:**

```bash
git submodule update --init --recursive
```
---

## Building the Softcore

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
   Or use Vivado GUI Hardware Manager with: `work/basys3-test-setup.runs/impl_1/basys3-test-setup.bit`

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

2. **Build and install the bootloader image generator:**
   
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

3. **Ensure RISC-V toolchain is in PATH** (installed automatically by Alire):
   
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

### Build the Demo Firmware

The neorv32-hal repository is already included as a submodule in this fork.

1. **Initialize and update submodules** (if not already done):
   ```bash
   git submodule update --init --recursive
   ```

2. **Navigate to the demos directory:**
   ```bash
   cd neorv32-hal/demos
   ```

3. **Build with Alire:**
   ```bash
   alr build
   ```

4. **Convert and package the firmware:**
   ```bash
   riscv64-elf-objcopy -O binary bin/bios bin/bios.bin
   image_gen -app_bin bin/bios.bin bin/bios.exe
   ```

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
