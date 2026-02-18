# Assumes only SystemVerilog (.sv) files are used
# Format is:
#    Product : List of Dependencies (Use \ at the end of the line for line continuation)
#
# Types of products are:
#    *.rtl.json:  Simulation file
#    *.vcd:  Value Change Dump (signal trace)
#    *.ice40.jpg:  Ice40 synthesis
#    *.aig.jpg:  AIG synthesis
#    *.bin:  bitstream
#    *.edit: Open the preceeding file for editing
#    *.riscv-sim: Simulate the file (using launch.json view; Must config launch.json)
#    *.ice40.dot: Ice40 synthesis in dot format
#    *.rom.txt: Convert a single .s file to assembly format for RISC-V ROM (Does not sanity check; Will remove any lines between <RM> and </RM> tags)
# Products still in alpha testing:
#	 *.placed.svg : Placement data and file viewer (requires webserver be running to view)
#	 *.router.svg : Router data and file viewer (requires webserver be running to view)
#
# A line preceeding a target that starts with a comment can "override" the type of target or the label used in the task
#   With either/both label="..." or type="..." (Types include a dot for the extension, like .edit or .rtl.json)
#   A type of "edit" can be used to open the file in code.
# Task names that begin with an _ in their label will not be shown in the task list, but can still be dependencies.
#
# There are also global dependencies that can be used to launch common tasks independent of specific modules or projects:
#   The type="server" can be used to include a task for the FPGA server
#   The type="rebuild" can be usd to include a task for rebuilding the tasks themselves (still need to be refreshed)


# label="05.01 Edit helloio.S" type=".edit"
helloio.S.edit: \

# label="_Edit helloio simulate.S" type=".edit" dependsOn=["05.01 Edit helloio.S"]
simulate.S.edit: \

# label="05.02 Simulate helloio.S" type=".riscv-sim" dependsOn=["_Edit helloio simulate.S"]
helloio_driver_sim.S.riscv-sim:


# label="05.03 Convert hellio.S+bootloader for iCE40 ROM"
products/helloio.rom.txt: \
	../../../common/bootloader.S \
	helloio.S \


# label="05.04 RISC-V+helloio.S bitstream" dependsOn=["05.03 Convert hellio.S+bootloader for iCE40 ROM"]
products/risc-v-helloio.bin: \
        top.sv \
        ledandkey.sv \
        pins.pcf \
        ../risc-v/riscvsingle.sv \
        imem.sv \
        dmem.sv \
        io.sv \
        helloio.S

# label="05.05 RISC-V+helloio.S placed"
products/risc-v-helloio.placed.svg: \
        top.sv \
        ledandkey.sv \
        pins.pcf \
        ../risc-v/riscvsingle.sv \
        imem.sv \
        dmem.sv \
        io.sv \
        helloio.S
