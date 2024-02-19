.extern print_array
.section .text

.set SIZEOF, 8
.set SIZEOF_SHIFT, 3

/*
Arguments:
a0 - a pointer to array of 64-bit values to be sorted
a1 - array length
*/
.globl quicksort
.type quicksort @function
quicksort:
	# if array length < 1, do not do anything
	li t0, 1
	bgt a1, t0, 1f 
	ret
1:
	# push arguments onto stack
	addi sp, sp, -48
	sd a0, (sp)
	sd a1, 8(sp)	
	sd ra, 16(sp)
	sd s0, 24(sp)
	sd s1, 32(sp)
	sd s2, 40(sp)

	# t0 = pointer to currently processed value
	mv t0, a0
	# t1 = end of array pointer
	slli t1, a1, SIZEOF_SHIFT
	add t1, t1, t0
	# t2 = pivot pointer (= last value)
	li t2, SIZEOF
	sub t2, t1, t2
	# t3 = pointer to value where pivot should be located 
	mv t3, t0
	# t4 = pivot value
	ld t4, (t2)
2:
	# if we are at pivot, proceed out of the loop
	# otherwise continue
	blt t0, t2, 3f
	j 5f
3:
	# t5 = value
	ld t5, (t0)
	
	# if value is in a correct half (is greater than pivot), go to end of the loop
	bge t5, t4, 4f

	# otherwise, it should be in (t3) 
	ld t6, (t3)
	sd t5, (t3)
	sd t6, (t0)
	addi t3, t3, SIZEOF 
4:
	# increment currently processed value and continue
	addi t0, t0, SIZEOF
	j 2b	

5:
	# swap pivot
	ld t5, (t3)
	sd t4, (t3)
	sd t5, (t2)

	# s0 = number of elements without pivot
	addi s0, a1, -1
	mv s1, t3

	# sort left side of pivot	
	# a0 = a0
	# a1 = number of items before pivot
	sub a1, t3, a0
	srli a1, a1, SIZEOF_SHIFT 
	mv s2, a1	

	la t6, quicksort
	jalr t6
	
	# a0 - one further than pivot
	addi a0, s1, SIZEOF
	# a1 - number of values after pivot
	sub a1, s0, s2
	# t6 = quicksort
	la t6, quicksort
	jalr t6 
	
	# restore values from stack
	ld a0, (sp)
	ld a1, 8(sp)
	ld ra, 16(sp)
	ld s0, 24(sp)
	ld s1, 32(sp)
	ld s2, 40(sp)
	addi sp, sp, 48

	ret
