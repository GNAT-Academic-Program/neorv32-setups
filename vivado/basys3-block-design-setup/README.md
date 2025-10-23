Note: Untested on other machines
The supplied build.tcl script uses relative directories to import the NEORV32 IP block, contstraints file, and a block design TCL file.

The block design TCL file includes a clocking wizard and the necessary connections.

The NEORV32 can be re-configured for additional functionality (more GPIO, UART, DMEM size, etc.)

Ideas for build.tcl were received from:
- https://www.reddit.com/r/FPGA/comments/p81p9f/how_to_transfer_a_vivado_project_using_tcl/
- https://www.fpgadeveloper.com/2014/08/version-control-for-vivado-projects.html/

The last part of build.tcl, for building the block design from the design_1.tcl file, was written using help from Perplexity.

Run build.tcl from Vivado->Tools->Run TCL

A neorv32_project folder should be made at the same directory as the build.tcl file.

You should be able to generate the bitstream after running synthesis.
