# Create Vivado project and generate bitstream
# Usage: vivado -mode batch -source create_project.tcl

set board "basys3"

# Get the script's directory for path resolution
set script_dir [file dirname [file normalize [info script]]]

# Create and clear output directory
set outputdir [file join $script_dir work]
file mkdir $outputdir

set files [glob -nocomplain "$outputdir/*"]
if {[llength $files] != 0} {
    puts "deleting contents of $outputdir"
    file delete -force {*}[glob -directory $outputdir *]; # clear folder contents
} else {
    puts "$outputdir is empty"
}

switch $board {
    "basys3" {
        set a7part "xc7a35tcpg236-1"
        set a7prj "${board}-test-setup"
    }
    default {
        puts "ERROR: Unknown board '$board'"
        exit 1
    }
}

# Create project
create_project -part $a7part $a7prj $outputdir

# Set the reference directory
set proj_dir [get_property directory [current_project]]

# Set board part repository path BEFORE setting board_part
set board_repo_path "[file normalize "$script_dir/../../../.Xilinx/Vivado/2024.2/xhub/board_store/xilinx_board_store"]"
if {[file exists $board_repo_path]} {
    set_property -name "board_part_repo_paths" -value $board_repo_path -objects [current_project]
    puts "INFO: Board repository path set to: $board_repo_path"
} else {
    puts "WARNING: Board repository path not found at: $board_repo_path"
    puts "INFO: Attempting to use default Vivado board repositories..."
}

# Now set the board part (version 1.2 instead of 1.1)
set_property board_part "digilentinc.com:${board}:part0:1.2" [current_project]
set_property target_language VHDL [current_project]

# Define filesets
## Core: NEORV32
set neorv32_core_files [glob -nocomplain [file join $script_dir ../../neorv32/rtl/core/*.vhd]]
if {[llength $neorv32_core_files] > 0} {
    add_files $neorv32_core_files
    set_property library neorv32 [get_files $neorv32_core_files]
    puts "INFO: Added [llength $neorv32_core_files] NEORV32 core files"
} else {
    puts "WARNING: No NEORV32 core files found at: [file join $script_dir ../../neorv32/rtl/core/]"
}

## Design: processor subsystem template (local version with modified reset polarity)
set neorv32_dir [file join $script_dir ../../neorv32]
set src_file [file join $neorv32_dir rtl/test_setups/neorv32_test_setup_bootloader.vhd]
set dst_file [file join $outputdir neorv32_test_setup_bootloader.vhd]

if {[file exists $src_file]} {
    puts "INFO: Reading and patching $src_file for Basys3..."
    set fd [open $src_file r]
    set fc [read $fd]
    close $fd

    # Adjust IMEM size
    regsub -all {IMEM_SIZE\s*:\s*natural\s*:=\s*[0-9\*]+;} \
        $fc {IMEM_SIZE : natural := 32*1024;} fc

    # Adjust DMEM size
    regsub -all {DMEM_SIZE\s*:\s*natural\s*:=\s*[0-9\*]+} \
        $fc {DMEM_SIZE : natural := 16*1024} fc

    # Invert reset polarity
    regsub -all {rstn_i\s*=>\s*rstn_i} \
        $fc {rstn_i => not(rstn_i)} fc

    # Write the modified copy into the project folder
    set out_fd [open $dst_file w]
    puts -nonewline $out_fd $fc
    close $out_fd

    puts "INFO: Patched file written to $dst_file"
    set fileset_design $dst_file
} else {
    puts "ERROR: Source file not found: $src_file"
    exit 1
}

## Constraints
set fileset_constraints [glob -nocomplain [file join $script_dir *.xdc]]
if {[llength $fileset_constraints] == 0} {
    puts "WARNING: No constraint files (.xdc) found in: $script_dir"
}

## Simulation-only sources
set fileset_sim [list \
    [file join $neorv32_dir sim/neorv32_tb.vhd] \
    [file join $neorv32_dir sim/sim_uart_rx.vhd]
]

# Add source files
add_files $fileset_design
if {[llength $fileset_constraints] > 0} {
    add_files -fileset constrs_1 $fileset_constraints
    puts "INFO: Added [llength $fileset_constraints] constraint file(s)"
}

set sim_files_added 0
foreach sim_file $fileset_sim {
    if {[file exists $sim_file]} {
        add_files -fileset sim_1 $sim_file
        incr sim_files_added
    }
}
puts "INFO: Added $sim_files_added simulation file(s)"

# Set top module
set_property top neorv32_test_setup_bootloader [current_fileset]

puts "INFO: Project setup complete. Starting synthesis and implementation..."

# Run synthesis, implementation and bitstream generation
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

puts "INFO: Build complete!"
