Note:
- The supplied windows_build.tcl script uses relative directories to import the NEORV32 IP block, constraints file, and a block design TCL file.
- The build.tcl is an older version that does not work on Windows. In Windows it would create the project in the AppRoaming folder and fail in block creation. it is solely for reference.
The block design TCL file includes a clocking wizard and the necessary connections.

The NEORV32 can be re-configured for additional functionality (more GPIO, UART, DMEM size, etc.) in the block design page.

Ideas for build.tcl were received from:
- https://www.reddit.com/r/FPGA/comments/p81p9f/how_to_transfer_a_vivado_project_using_tcl/
- https://www.fpgadeveloper.com/2014/08/version-control-for-vivado-projects.html/

The last part of build.tcl and windows_build.tcl, for building the block design from the design_1.tcl file, was written using help from Perplexity.
Instructions:
1) Download Basys 3 board setup
a) Create a new project and press Next until you reach the "Default Part" screen.
b) Switch to the "Boards" menu.
c) Refresh index
d) Search for "Basys"
e) Install Basys3 support

2) Run windows_build.tcl from Vivado->Tools->Run TCL
(Run the windows_build.tcl file in the directory it is. If you move it to some other folder, then maintiain the directory structure of basys3-block-design-setup)
A neorv32_project folder should be made at the same directory as the build.tcl file.

You should be able to generate the bitstream after running synthesis.

