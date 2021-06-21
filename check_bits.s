#.data

#.include "call_check_bits.s"

#.text
#.globl _start
#start:


#done:
#    nop

checkBits:                 
    push %rcx                       # Preserving rcx, r10,      
    push %r10    
    mov 40(%rsp), %r10d             # Shift right to position target bit. Use and to check if that bit is 1 or 0
    mov 32(%rsp), %rcx              # Checks 2 bit positions. if both are 1, then return 1. else return 0 
    shr %cl, %r10d                  # shr only works with %cl
    and $0x1, %r10d                 # this and checks if the least sig bit is 1
    mov %r10, %rax  
    cmp $0, %rax
    je funcEnd
    mov 40(%rsp), %r10d
    mov 24(%rsp), %rcx
    shr %cl, %r10d
    and $0x1, %r10d
    mov %r10, %rax
    jmp funcEnd

funcEnd:
    pop %r10
    pop %rcx
    ret



#as --gstabs call_check_bits.s -o call_check_bits.o
#ld call_check_bits.o -o call_check_bits
#gdb ./call_check_bits
