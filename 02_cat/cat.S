.section .text

.set READ, 63
.set WRITE, 64
.set EXIT, 93
.set OPENAT, 56
.set CLOSE, 57

.set STDIN, 0
.set STDOUT, 1

.set AT_FDCWD, -100
.set BUFFER_SIZE, 4096

.globl _start

/* Copies file opened in x1 to file opened in x0

Returns 0 on success and 1 on failure
*/
copy_file:
	# store argument registers
	mv t0, a0
	mv t1, a1
	
1:
	# read into buffer
	li a7, READ
	mv a0, t1
	la a1, buffer
	li a2, BUFFER_SIZE
	ecall
	
	# store no of bytes read
	mv t2, a0
	# if read 0 bytes, move out of the loop
	beqz a0, 2f

	# write from buffer
	li a7, WRITE
	mv a0, t0
	la a1, buffer
	mv a2, t2
	ecall
2:
	ret


_start:
	# read number of arguments
	ld s0, (sp)

	# if 0 arguments (argc = 1), redirect stdin
	li t0, 1
	bne s0, t0, _cat_args
_redirect_stdin:
	# copy stdin to stdout
	li a0, STDOUT
	li a1, STDIN
	la t0, copy_file
	jalr t0
	la t0, _exit
	jal _exit
_cat_args:
	# current argument number
	li s1, 1
1:	
	# calculate stack offset
	addi t0, s1, 1
	slli t0, t0, 3
	
	# open file
	li a7, OPENAT
	add t0, sp, t0
	li a0, AT_FDCWD
	ld a1, (t0)
	mv a2, x0
	ecall

	# write it to stdout
	mv a1, a0
	la a0, STDOUT
	la t0, copy_file
	jalr t0

	# close file
	li a7, CLOSE
	mv a0, a1
	ecall

	# repeat if not last arg
	addi s1, s1, 1
	ble s1, s0, 1b
_exit:
	# exit with code 0
	li a7, EXIT
	mv a0, x0
	ecall	

	ebreak

.section .bss
	buffer: .fill BUFFER_SIZE

