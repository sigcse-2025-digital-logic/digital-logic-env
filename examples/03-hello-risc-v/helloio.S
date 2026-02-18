#define asciiz asciz
.text
.globl main
main:
    # ? In-class, Active Learning Exercise: https://washu-cse2600-fl25.github.io/studios/studio06a#hello-io--calling-all-ecalls

    # TODO: Complete code to do an ecall to show "hi" on the 7-segment display's rightmost 2 displays

    # TODO: See https://github.com/digital-logic-and-computer-design/vscode-riscv-venus-2?tab=readme-ov-file#led-and-key-board
    # TODO (optional/as-needed): See RISC-V Assembly Reference: https://pages.hmc.edu/harris/ddca/ddcarv/DDCArv_AppB_Harris.pdf
    li a0, 0x152     # Ecall code: OS should apply what's in
    li a1, 0x11      # FIXME: This will turn on the top and bottom/left of the rightmost display
    ecall

    # ! Leave the infinite loop below (otherwise "hi" will be erased too quickly)
loop:
    j loop
   # End the run
    li a0, 10
    ecall
    # ! Spoiler Alert solution below (scroll)







































    # ? Solution below:
    # li a1, 0x7410    # LEDs to activate
