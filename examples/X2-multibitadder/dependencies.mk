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
#
# There are also global dependencies that can be used to launch common tasks independent of specific modules or projects:
#   The type="server" can be used to include a task for the FPGA server
#   The type="rebuild" can be usd to include a task for rebuilding the tasks themselves (still need to be refreshed)



# label="X2.1 Edit adder.sv" type=".edit"
adder.sv.edit:

# label="X2.2 Simulate adder.sv"
products/adder.rtl.json: \
	fulladder.sv \
	adder.sv \

# label="X2.3 adder testbench verification"
products/adder_tb.vcd: \
	fulladder.sv \
	adder.sv \
	adder_tb.sv

# label="X2.4 adder iCE40 synthesis mapping"
products/adder.ice40.jpg: \
	fulladder.sv \
 	adder.sv \

# label="X2.5 adder iCE40 bitstream"
products/adder.bin: \
	fulladder.sv \
 	adder.sv \
	top.sv \
	ledandkey.sv \
	pins.pcf


