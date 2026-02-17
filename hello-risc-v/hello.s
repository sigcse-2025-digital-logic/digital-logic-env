
 .text
 main:
    # Practice using Environment Calls (ecall)
    # Supported ecalls and parameters are described at https://marketplace.visualstudio.com/items?itemName=hm.riscv-venus

    # Ecall code to write to dual segment displays
    # Code: 0x120
    # Parameters:
    # a0: 16-bit values to apply.  Bits are:
    #     +-8-+  +-0-+
    #     |   |  |   |
    #    13   9  5   1
    #     |   |  |   |
    #     +14-+  +-6-+
    #     |   |  |   |
    #    12  10  4   2
    #     |   |  |   |
    #     +11-+  +-3-+
    # a1: 16-bit mask to select which segments to update
    #
    #

    li a0, 0x120      # ecall code for display
    # TODO: Set the bits to display "Hi"
    #        111111
    #        5432109876543210
    li  a1, 0b0  # FIXME!

    # ? Solution below:
    # li a1, 0b0111010000010000

    li a2, 0xFFFF     # Mask
    ecall


loop:
    j loop
