# Assumes only SystemVerilog (.sv) files are used
# Format is:
#    Product : List of Dependencies
#    (Use \ at the end of the line for line continuation)
# Types of products are:
#    *.rtl.json:  Simulation file
#    *.vcd:  Value Change Dump (signal trace)
#    *.ice40.jpg:  Ice40 synthesis
#    *.aig.jpg:  AIG synthesis
#    *.bin:  bitstream
#    *.edit: Open the preceeding file for editing
#    *.riscv-sim: Simulate the file (using launch.json view; Must config launch.json)
# A line preceeding a target that starts with a comment can "ovverride" the type of target or the label used in the task
#   With either/both label="..." or type="..." (Types include a dot for the extension, like .edit or .rtl.json)
#   A type of "edit" can be used to open the file in code.


# label="5.1 Edit adder.sv" type=".edit"
adder.sv.edit:

# label="5.2 Simulate adder.sv"
products/adder.rtl.json: \
	fulladder.sv \
	adder.sv \

# label="5.3 adder testbench verification"
products/adder_tb.vcd: \
	fulladder.sv \
	adder.sv \
	adder_tb.sv

# label="5.4 adder iCE40 synthesis mapping"
products/adder.ice40.jpg: \
	fulladder.sv \
 	adder.sv \

# label="5.5 adder iCE40 bitstream"
products/adder.bin: \
	fulladder.sv \
 	adder.sv \
	top.sv \
	ledandkey.sv \
	pins.pcf


