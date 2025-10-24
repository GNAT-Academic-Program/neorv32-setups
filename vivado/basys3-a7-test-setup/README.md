# NEORV32 Test Setup for the Digilent Basys3 FPGA Board

This setup provides a very simple script-based "demo setup" that allows to check out the NEORV32 processor on the Digilent Basys3 board.
It uses a modified version of the simplified [`neorv32_test_setup_bootloader.vhd`](https://github.com/stnolting/neorv32/blob/master/rtl/test_setups/neorv32_test_setup_bootloader.vhd) top entity (local copy with inverted reset polarity), which is a wrapper for the actual processor top entity that provides a minimalistic interface (clock, reset, UART).

* FPGA Board: :books: [Digilent Basys3 FPGA Board](https://reference.digilentinc.com/reference/programmable-logic/basys-3/reference-manual)
* FPGA: Xilinx Artix-7 `XC7A35TCPG236-1`
* Toolchain: Xilinx Vivado (tested with Vivado 2019.2 and later)

## NEORV32 Configuration

:information_source: See the local top entity `neorv32_test_setup_bootloader.vhd` for configuration and entity details, and `basys3_a7_test_setup.xdc` for the FPGA pin mapping.

**Note:** This setup uses a local copy of the test setup VHDL file because the Basys3 board has **active-low reset** button, which requires inverting the reset signal (`rstn_i => not(rstn_i)` in the port map).

* CPU: `rv32imc_Zicsr` + performance counters
* Memory: 32kB instruction memory (internal IMEM), 16kB data memory (internal DMEM), bootloader ROM
* Peripherals: `GPIO`, `CLINT`, `UART0`
* Clock: 100MHz from on-board oscillator
* Reset: Via dedicated on-board "BTNC" (center button) - **active-low**
* GPIO output port `gpio_o` - 8 bits available (not connected to LEDs in this minimal setup)
* UART0 signals `uart0_txd_o` and `uart0_rxd_i` are connected to the on-board USB-UART interface

## Usage

### 1. Set Up the Repository

Run the following command from your top-level project directory to clone the repository:

```bash
git clone https://github.com/GNAT-Academic-Program/neorv32-setups
```

Next, move the working directory to the repository:

```bash
cd neorv32-setups
```

Fetch the latest git changes:

```bash
git fetch
```

Update the submodules recursively:

```bash
git submodule update --init --recursive
```

Finally, move the working directory to the basys3-a7-test-setup folder:

```bash
cd vivado/basys3-a7-test-setup
```

### 2. Generate the Bitstream

Run the following command from this directory to create the Vivado project and generate the bitstream:

```bash
vivado -mode batch -source create_project.tcl
```

This will:
- Create a `work/` directory with the Vivado project
- Run synthesis and implementation
- Generate the bitstream at: `work/basys3-test-setup.runs/impl_1/neorv32_test_setup_bootloader.bit`

### 3. Program the FPGA

You can program the FPGA using either:

**Option A: Vivado GUI**
- Open the Vivado Hardware Manager
- Connect to your Basys3 board
- Program the device with the generated `.bit` file

**Option B: Command-line script**
```bash
vivado -mode batch -source program_bitstream.tcl
```

### 3. Connect via UART

- The Basys3 board's USB-UART interface will appear as a serial port on your computer
- Connect using a terminal program (e.g., VS Code Serial Monitor, PuTTY) at **19200 baud, 8N1**
- Press the center button (BTNC) to reset the processor
- You should see the NEORV32 bootloader prompt

## Notes

- The `work/` directory and Vivado-generated files are git-ignored
- The local `neorv32_test_setup_bootloader.vhd` file has modified reset polarity compared to the standard version
- GPIO outputs are defined but not connected to LEDs in the constraints file - you can uncomment LED connections in the `.xdc` file if needed
