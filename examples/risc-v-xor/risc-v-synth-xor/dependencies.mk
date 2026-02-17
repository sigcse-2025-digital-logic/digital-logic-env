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

# label="4.2 RISC-V+xor_driver_hardware.s bitstream" dependsOn="4.1 Convert xor_driver_hardware to ROM for iCE40 ROM"
products/riscvsingle.bin: \
	top.sv \
	ledandkey.sv \
	pins.pcf \
	../risc-v/riscvsingle.sv \
	imem.sv \
	dmem.sv \
	io.sv


