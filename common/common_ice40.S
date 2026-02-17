# Emulate the behavior of basic ecalls for I/O board
#   Calls for 0x150 - 0x156 at https://github.com/digital-logic-and-computer-design/vscode-riscv-venus-2
.text
.globl ecall_proxy
ecall_proxy:
  addi sp,sp, -16
  sw s0, 0(sp)
  sw s1, 4(sp)
  sw s2, 8(sp)
  sw s3, 12(sp)

  li s0, 0x8000

  li s1, 0x150
  bne a0,s1, ecall_proxy_right_7segs
ecall_proxy_leds:
  sw a1, 8(s0)
  j ecall_proxy_end

ecall_proxy_right_7segs:
  li s1, 0x152
  bne a0,s1, ecall_proxy_left_7segs
  sw a1, 0(s0)
  j ecall_proxy_end

ecall_proxy_left_7segs:
  li s1, 0x154
  bne a0,s1, ecall_proxy_buttons
  sw a1, 4(s0)
  j ecall_proxy_end

ecall_proxy_buttons:
  li s1, 0x156
  bne a0,s1, ecall_proxy_readleds
  lw a0, 12(s0)
  j ecall_proxy_end

ecall_proxy_readleds:
  li s1, 0x151
  bne a0,s1, ecall_proxy_readright_7segs
  lw a0, 8(s0)
  j ecall_proxy_end

ecall_proxy_readright_7segs:
  li s1, 0x153
  bne a0,s1, ecall_proxy_readleft_7segs
  lw a0, 0(s0)
  j ecall_proxy_end

ecall_proxy_readleft_7segs:
  li s1, 0x155
  bne a0,s1, ecall_proxy_end
  lw a0, 4(s0)

ecall_proxy_end:
  lw s0, 0(sp)
  lw s1, 4(sp)
  lw s2, 8(sp)
  lw s3, 12(sp)
  addi sp,sp,16
  jr ra
