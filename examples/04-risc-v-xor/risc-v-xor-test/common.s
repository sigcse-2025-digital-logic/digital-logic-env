.text
.globl set_segments
# Parameters
#   a0 is the 7-segment to change (0 is rightmost / least significant digit on the display)
#   a1 is the value to set (low 8 bits)
# Return value
#   none / undefined
# Side effects
#   all non-caller-saves registers may be changed
set_segments:
    addi sp, sp, -4
    sw ra, 0(sp)
    slli a0, a0, 3     # Multiply digit by 8 to get shift amount

    andi a1, a1, 0xFF  # Mask to only needed bits
    sll a1, a1, a0   # And put in place

    li a2, 0xFF        # Create mask
    sll a2,a2,a0

    # Workaround for display masking error in Venus extension
    lw t0, display_segments # Get current value
    not t1, a2 # Invert mask
    and t2, t0, t1 # old & ~mask
    and t3, a1, a2 # new & mask
    or a1, t2, t3 # Combine the two: (old & ~mask) | (new & mask)
    # Store it back
    la t0, display_segments

    sw a1, 0(t0) # Store the new value

    li a2, 0xFFFF      # Set the mask to all
    li a0,0x120        # Env. call to set
    ecall
    jal destroy_callee_regs # Have fun!

    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra

.data
display_segments: .word 0

.text

.globl washer_set_outputs
washer_set_outputs:
# Parameters
#   a0 is set of control values to apply
#     bit 0: Soap (1 = on)
#     bit 1: Hot (1 = on)
#     bit 2: Cold (1 = on)
#     bit 3: HighPressure (1 = on)
#     bit 4: AirDry (1 = on)
#     bit 5: ExtraHotAir (1 = on)
# Return value
#   none / undefined
# Side effects
#   control values are simulated on digit 0 (right digit) of the 7-segement display
    addi sp, sp, -4
    sw ra, 0(sp)
    mv a1,a0
    li a0, 0
    jal set_segments
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra








.text
## Checking callees:
#   1. Setup Arguments
#   2. jal checkpoint_regs
#   2. Call test routine (jal  ... )
#   3. jal check_regs


# checkpoint_regs: Save all "callee preserved" registers so callee-use
#                   conventions can be checked
.globl checkpoint_regs
checkpoint_regs:
    addi sp, sp, -48

    # Store all the s-regs
    sw s0,   0(sp)
    sw s1,   4(sp)
    sw s2,   8(sp)
    sw s3,  12(sp)
    sw s4,  16(sp)
    sw s5,  20(sp)
    sw s6,  24(sp)
    sw s7,  28(sp)
    sw s8,  32(sp)
    sw s9,  36(sp)
    sw s10, 40(sp)
    sw s11, 44(sp)

    # Save the sp
    la s0, saved_sp   # Save callers sp-44
    sw sp, 0(s0)

    # Set all the regs
    li s0,  0xBADBAD0
    li s1,  0xBADBAD1
    li s2,  0xBADBAD2
    li s3,  0xBADBAD3
    li s4,  0xBADBAD4
    li s5,  0xBADBAD5
    li s6,  0xBADBAD6
    li s7,  0xBADBAD7
    li s8,  0xBADBAD8
    li s9,  0xBADBAD9
    li s10, 0xBADBADA
    li s11, 0xBADBADB

    jr ra


# check_regs: Check all "callee preserved" registers to ensure they were preserved
.globl check_regs
check_regs:
    # Check all the sregs
    addi sp, sp, -16
    sw a0, 0(sp)
    sw a1, 4(sp)
    sw a2, 8(sp)
    sw a3, 12(sp)

    lw a0, saved_sp

    addi a0, a0, -16
    # See if the sp is the expected value (saved value - 16)
    beq sp, a0, check_s0
        li a0, 4
        la a1, s_stack
        ecall
        li a0, 17
        li a1, 1
        ecall

check_s0:
    li a0, 0xBADBAD0
    beq s0, a0, check_s1
        li a0, 4
        la a1, s_s0
        ecall
check_s1:
    li a0, 0xBADBAD1
    beq s1, a0, check_s2
        li a0, 4
        la a1, s_s1
        ecall
check_s2:
    li a0, 0xBADBAD2
    beq s2, a0, check_s3
        li a0, 4
        la a1, s_s2
        ecall
check_s3:
    li a0, 0xBADBAD3
    beq s3, a0, check_s4
        li a0, 4
        la a1, s_s3
        ecall
check_s4:
    li a0, 0xBADBAD4
    beq s4, a0, check_s5
        li a0, 4
        la a1, s_s4
        ecall
check_s5:
    li a0, 0xBADBAD5
    beq s5, a0, check_s6
        li a0, 4
        la a1, s_s5
        ecall
check_s6:
    li a0, 0xBADBAD6
    beq s6, a0, check_s7
        li a0, 4
        la a1, s_s6
        ecall
check_s7:
    li a0, 0xBADBAD7
    beq s7, a0, check_s8
        li a0, 4
        la a1, s_s7
        ecall
check_s8:
    li a0, 0xBADBAD8
    beq s8, a0, check_s9
        li a0, 4
        la a1, s_s8
        ecall
check_s9:
    li a0, 0xBADBAD9
    beq s9, a0, check_s10
        li a0, 4
        la a1, s_s9
        ecall
check_s10:
    li a0, 0xBADBADA
    beq s10, a0, check_s11
        li a0, 4
        la a1, s_s10
        ecall
check_s11:
    li a0, 0xBADBADB
    beq s11, a0, check_done
        li a0, 4
        la a1, s_s11
        ecall

check_done:
    lw a0, 0(sp)
    lw a1, 4(sp)
    lw a2, 8(sp)
    lw a3, 12(sp)
    addi sp, sp, 16  # restore this frame

    # Restore stored value
    lw s0,   0(sp)
    lw s1,   4(sp)
    lw s2,   8(sp)
    lw s3,  12(sp)
    lw s4,  16(sp)
    lw s5,  20(sp)
    lw s6,  24(sp)
    lw s7,  28(sp)
    lw s8,  32(sp)
    lw s9,  36(sp)
    lw s10, 40(sp)
    lw s11, 44(sp)
    addi sp,sp, 48

    jr ra


.globl destroy_callee_regs
destroy_callee_regs:
    li t0, 0xB0BADBAD
    li t1, 0xB1BADBAD
    li t2, 0xB2BADBAD
    li t3, 0xB3BADBAD
    li t4, 0xB4BADBAD
    li t5, 0xB5BADBAD
    li t6, 0xB6BADBAD
    li a0, 0xC0BADBAD
    li a1, 0xC1BADBAD
    li a2, 0xC2BADBAD
    li a3, 0xC3BADBAD
    li a4, 0xC4BADBAD
    li a5, 0xC5BADBAD
    li a6, 0xC6BADBAD
    li a7, 0xC7BADBAD
    jr ra



.data
saved_sp: .word 0
s_stack:  .asciiz "ERROR: sp not preserved --- quitting!\r\n"

s_s0: .asciiz "ERROR: s0 not preserved!\r\n"
s_s1: .asciiz "ERROR: s1 not preserved!\r\n"
s_s2: .asciiz "ERROR: s2 not preserved!\r\n"
s_s3: .asciiz "ERROR: s3 not preserved!\r\n"
s_s4: .asciiz "ERROR: s4 not preserved!\r\n"
s_s5: .asciiz "ERROR: s5 not preserved!\r\n"
s_s6: .asciiz "ERROR: s6 not preserved!\r\n"
s_s7: .asciiz "ERROR: s7 not preserved!\r\n"
s_s8: .asciiz "ERROR: s8 not preserved!\r\n"
s_s9: .asciiz "ERROR: s9 not preserved!\r\n"
s_s10: .asciiz "ERROR: s10 not preserved!\r\n"
s_s11: .asciiz "ERROR: s11 not preserved!\r\n"
