.globl _start
_start:
    # Initialize stack pointer
    li sp, 0x1000

    # Call main
    jal main

    li t0, 0x8000
    li t1, 0x5E3F5479 # dOnE
    sw t1, 0(t0)  # Update LEDs: RGB on
done:
    j done
