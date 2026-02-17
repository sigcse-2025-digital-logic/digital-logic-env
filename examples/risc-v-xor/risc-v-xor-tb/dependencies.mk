# Assumes only SystemVerilog (.sv) files are used
# Format is:
#    Product : List of Dependencies
#    (Use \ at the end of the line for line continuation)
# Types of products are:
#    *.rtl.json:  Simulation file
#    *.vcd:  Value Change Dump (signal trace)
#    *.ice40.jpg:  Ice40 synthesis
#    *.aig.jpg:  AIG synthesis
#    *.bin:  bitstream / programming
#

# label="04.10 RISC-V xor Testbench"
products/risc-v-xor-tb.vcd: \
	risc-v-xor-tb.sv \
	riscvsingle.sv

# label="04.11 Edit xor Testbench"
risc-v-xor-tb.sv.edit: \

