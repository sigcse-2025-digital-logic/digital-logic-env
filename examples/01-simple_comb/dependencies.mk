# Assumes only SystemVerilog (.sv) files are used
# Format is:
#    Product : List of Dependencies (Use \ at the end of the line for line continuation)
#
# Types of products are:
#    *.rtl.json:  Simulation file
#    *.vcd:  Value Change Dump (signal trace)
#    *.ice40.jpg:  iCE40 synthesis
#    *.aig.jpg:  AIG synthesis
#    *.bin:  bitstream
#    *.edit: Open the preceeding file for editing
#    *.riscv-sim: Simulate the file (using launch.json view; Must config launch.json)
#    *.ice40.dot: iCE40 synthesis in dot format
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



# label="01.01 Edit simple_comb.sv" type=".edit"
simple_comb.sv.edit:

# label="01.02 Simulate simple_comb.sv"
products/simple_comb.rtl.json: \
	simple_comb.sv \

# label="01.03 simple_comb testbench verification"
products/simple_comb_tb.vcd: \
	simple_comb.sv \
	simple_comb_tb.sv


# label="01.04 iCE40 Bitstream"
products/simple_comb.bin: \
	simple_comb.sv \
	top.sv \
	ledandkey.sv \
	pins.pcf


# label="01.05 AIG Mapping"
# products/simple_comb.aig.jpg: \
# 	simple_comb.sv \

# label="01.05 iCE40 placed"
products/simple_comb.placed.svg: \
	simple_comb.sv \
	top.sv \
	ledandkey.sv \
	pins.pcf

# # label="01.06 iCE40 routed"
# products/simple_comb.routed.svg: \
# 	simple_comb.sv \
# 	top.sv \
# 	ledandkey.sv \
# 	pins.pcf
