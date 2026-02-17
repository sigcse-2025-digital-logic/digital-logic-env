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

# label="03.01 Edit helloio.S" type=".edit"
helloio.S.edit: \

# label="03.02 Run helloio.S" type=".riscv-sim" dependsOn="5.1 Edit helloio.S"
helloio.S.riscv-sim:

# label="03.03 Rebuild helloio.S SOC Firmware"
products/helloio.S.fw.bin: \
	helloio.S



