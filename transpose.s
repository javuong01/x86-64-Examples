transpose:
    #space for preserving
    push %r10
    push %r13
    push %r14
    push %r15
    push %rax
    push %rcx
    push %rdx

    mov 64(%rsp), %r10d              # output
    #mov 16(%rsp), %r11d             # columns (output)     also uneccessary
    #mov 24(%rsp), %r12d             # rows (output)        also uneccessary
    mov 88(%rsp), %r13d             # input
    mov $0, %r14d                   # counter for input
    mov $0, %r15d                   # counter for how far in the row
    mov $0, %eax                    # placeholder for moving input to output
    mov $0, %ecx                    # counter for output
    mov $-1, %edx                   # counter for rows
    jmp nextRow

rowLoop:                            # fills a row of the output with a column of the input
    cmp 80(%rsp), %r15d
    #cmp %r12d, %r15d               # this line is redone above
    jge nextRow
    mov (%r13d, %r14d, 4), %eax     # scale-factor addressing for arrays
    mov %eax, (%r10d, %ecx, 4)
    add $1, %r15d
    add 72(%rsp), %r14d
    #add %r11d, %r14d               # this line is redone above
    add $1, %ecx
    jmp rowLoop

nextRow:                            # allows next row to be filled by moving to next column
    add $1, %edx
    cmp 72(%rsp), %edx
    #cmp %r11d, %edx                # this line is redone above
    jge funcEnd
    mov $0, %r15d
    mov %edx, %r14d
    jmp rowLoop

funcEnd:                            # unpreserving registers and ending function
    pop %rdx
    pop %rcx
    pop %rax
    pop %r15
    pop %r14
    pop %r13
    pop %r10
    ret

#as --gstabs call_transpose.s -o call_transpose.o
#ld call_transpose.o -o call_transpose
#gdb ./call_transpose
