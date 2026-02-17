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
#    *.rom.txt: Convert a single .s file to assembly format for RISC-V ROM (Does not sanity check; Will remove any lines between <RM> and </RM> tags)

# label="6.1 Edit hello.s" type=".edit"
hello.s.edit: \

# label="6.2 Simulate hello.s" type=".riscv-sim" dependsOn="6.1 Edit hello.s"
hello.s.riscv-sim:



