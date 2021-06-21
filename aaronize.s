aaronize:
	#Preserver Registers	
	push %r8
	push %r9
	push %r10
	push %r11
	push %r12
	push %r13
	push %r14
	push %r15
	push %rax

	mov 80(%rsp), %r8d			# output aray
	mov 88(%rsp), %r15d			# aaronize times
	mov 96(%rsp), %eax			# arrlen
	mov 104(%rsp), %r9d			# input array
	mov $1, %r10d				# aaronize counter
	
aaronizeCount:
	mov $0, %r11d
	mov $1, %r12d
	mov $2, %r13d
	cmp %r15d, %r10d
	jg funcEnd
    cmp $2, %r10d
	je arraySwap
	mov $0, %r14d			# used as a placeholder for arrayswap and arronize
	jmp aaronizeFirst

arraySwap:					# output array is used instead of input after first aaronize
    mov 80(%rsp), %r9d
	jmp aaronizeFirst

aaronizeFirst:                  # This aaronizes the first index. adds index 0, 1
	mov $0, %r14d
    add (%r9d, %r11d, 4), %r14d
    add (%r9d, %r12d, 4), %r14d
	push %r14
	jmp aaronizeLoop
		
aaronizeLoop:                   # This arronizes the index that isn't first or last and loops
	cmp %eax, %r13d
    jge aaronizeLast
	mov $0, %r14d
    add (%r9d, %r11d, 4), %r14d
    add (%r9d, %r12d, 4), %r14d
    add (%r9d, %r13d, 4), %r14d
	push %r14
    add $1, %r11d
    add $1, %r12d
    add $1, %r13d
	jmp aaronizeLoop

aaronizeLast:                   # This aaronizes the last index. adds index second to last, last
	mov $0, %r14d
    add (%r9d, %r11d, 4), %r14d
    add (%r9d, %r12d, 4), %r14d
	push %r14
    add $1, %r10d
	mov %eax, %r11d		# temp placeholder for printOutput
	jmp printOutput

printOutput:
	sub $1, %r11d
	cmp $0, %r11d
	jl aaronizeCount
	pop %r14
	mov %r14d, (%r8d, %r11d, 4)
	jmp printOutput


funcEnd:
	# Unpreserve Registers
	pop %rax
	pop %r15
	pop %r14
	pop %r13
	pop %r12
	pop %r11
	pop %r10
	pop %r9
	pop %r8
    ret

#as --gstabs call_aaronize.s -o call_aaronize.o
#ld call_aaronize.o -o call_aaronize
#gdb ./call_aaronize
