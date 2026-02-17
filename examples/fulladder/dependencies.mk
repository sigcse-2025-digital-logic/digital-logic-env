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


# label="4.11 Edit fulladder.sv" type=".edit"
fulladder.sv.edit:


# label="4.12 Simulate fulladder.sv"
products/fulladder.rtl.json: \
	fulladder.sv \

# label="4.13 fulladder testbench verification"
products/fulladder_tb.vcd: \
	fulladder.sv \
	fulladder_tb.sv


# label="4.17 fulladder AIG"
products/fulladder.aig.jpg: \
	fulladder.sv \



