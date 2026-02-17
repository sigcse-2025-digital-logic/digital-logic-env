#define asciiz asciz
.text
.globl main
main:
    # TODO: Complete code to do an ecall_proxy to show "hi" on the 7-segment display's rightmost 2 displays
    # TODO: See https://github.com/digital-logic-and-computer-design/vscode-riscv-venus-2?tab=readme-ov-file#led-and-key-board
    # TODO (optional/as-needed): See RISC-V Assembly Reference: https://pages.hmc.edu/harris/ddca/ddcarv/DDCArv_AppB_Harris.pdf

    li a1, 0x11      # FIXME: This will turn on the top and bottom/left of the rightmost display

    # ! DONE: Copy the value in a1 to Mem[0x8000], which is the right set of 7-segment displays
    # li s0, 0x8000  # no lui version
    li s0, 0x8
    slli s0, s0, 12
    sw a1, 0(s0)

    # ! Leave the infinite loop below
loop:
    # TODO / Challenge: Copy the values of Keys to LEDs
    # Mem[0x8000]: Right 7-Segments (read/write) / 32 bits
    # Mem[0x8004]: Left 7-Segments (read/write) / 32 bits
    # Mem[0x8008]: LEDs (read/write) / Lower 8 bits
    # Mem[0x800C]: Keys (read/write) / lower 8 bits
    j loop
    # ! Spoiler Alert solution below (scroll)







































    # ? Solution below:
    # li a1, 0x7410    # LEDs to activate


    # lw t0, 0xC(s0)
    # sw t0, 0x8(s0)
