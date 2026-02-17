# Assumes only SystemVerilog (.sv) files are used
# Format is:
#    Product : List of Dependencies
#    (Use \ at the end of the line for line continuation)
# Types of products are:
#    *.rtl.json:  Simulation file
#    *.vcd:  Value Change Dump (signal trace)
#

# label="4.1 Edit statemachine.sv" type=".edit"
statemachine.sv.edit:



# label="4.2 Simulate statemachine.sv"
statemachine.rtl.json: \
	statemachine.sv

# label="4.3 Edit statemachine_tb.sv" type=".edit"
statemachine_tb.sv.edit:

# label="4.4 statemachine testbench verification"
statemachine_tb.vcd: \
	statemachine.sv \
	statemachine_tb.sv


# label="4.5 statemachine iCE40 bitstream"
products/statemachine.bin: \
	statemachine.sv \
	top.sv \
	ledandkey.sv \
	risingedge_detector.sv \
	pins.pcf
