
.globl main
main:
    # Check for start button
    ori t0, zero, 0x400
    add t0, t0, t0  # 0x800
    add t0, t0, t0  # 0x1000
    add t0, t0, t0  # 0x2000
    add t0, t0, t0  # 0x4000
    add t0, t0, t0  # 0x8000

    # Get pointers
    mv   t1, t0      # Display
    addi t2, t0, 0xC # Keys

main_loop:
    lw t3, 0(t2) # Read the keys

    # TODO:  You can edit the 0x55 below to change the value being xor'd with the keys
    xori t3,t3, 0x55

    # ! Don't change below this
    li t4, 0xFF
    and t3,t3, t4  # Mask to last 8 only

    sw t3, 0(t1) # Write the Display
    j main_loop

