.section .text

.globl _start
_start:
	li a7, 64
	li a1, 1
	mv a1, x0
	mv a1, x1
	la a1, message
	li a2, 14
	ecall	

	li a7, 93
	mv a0, x0
	ecall	

	ebreak

.section .data
	message: .ascii "Hello, world!\n"
	message_end: 

