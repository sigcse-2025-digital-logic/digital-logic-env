.globl main
main:
    addi sp, sp, -4
    sw ra, 0(sp)

    call helloio

# Should be unreachable
main_end:
    j main_end
    lw ra, 0(sp)
    addi sp, sp, 4
    ret
