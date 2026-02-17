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
#    *.placed.svg:  Placement data/image
#    *.routed.svg:  Routing data/image
# A line preceeding a target that starts with a comment can "ovverride" the type of target or the label used in the task
#   With either/both label="..." or type="..." (Types include a dot for the extension, like .edit or .rtl.json)
#   A type of "edit" can be used to open the file in code.


# label="4.01 simple_comb testbench verification"
products/simple_comb_tb.vcd: \
	simple_comb.sv \
	simple_comb_tb.sv

# label="4.02 Edit simple_comb.sv" type=".edit"
simple_comb.sv.edit:

# label="4.03 Simulate simple_comb.sv"
products/simple_comb.rtl.json: \
	simple_comb.sv \

# label="4.04 simple_comb AIG Mapping"
products/simple_comb.aig.jpg: \
	simple_comb.sv \

