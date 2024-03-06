.data
    a: .word 1,2,3,4,5
    b: .word 6,7,8,9,10
    newline: .asciiz "\n"

.text
main:
    la a0 a # load address of a
    la a1 b # load address of b
    li a2 5 # size = a2 = 5

    jal dot_product_recursive #call functions
    
    j done # go to done label when function has finished
    
dot_product_recursive:
    addi sp sp -16 # 4 elements
    sw a0 0(sp) # save a
    sw a1 4(sp) # save b
    sw a2 8(sp) # save size
    sw ra 12(sp) # save ra
    # base case
    addi t0 zero 1  # t0 = 1
    bne a2 t0 else
    # under base case
    addi sp sp 16
    lw t1 0(a0) # t1 = a[0]
    lw t2 0(a1) # t2 = b[0]
    mul a0 t1 t2 # a0 = t1 * t2
    jr ra
    
else:
    #dot_product_recursive(a+1, b+1, size-1)
    addi a0 a0 4 # a += 1
    addi a1 a1 4 # b += 1
    addi a2 a2 -1 # size -= 1
    jal dot_product_recursive
    
    lw t1 0(sp) # load  a
    lw t2 4(sp) # load b
    lw t3 8(sp) # load size
    lw ra 12(sp) # load ra
    addi sp sp 16 # reset stack

    # (a[0] * b[0]) + dot_product_recursive(a+1, b+1, size-1)
    lw t4 0(t1) # t4 = a[0]
    lw t5 0(t2) # t5 = b[0]
    mul t6 t4 t5 # t6 = (t4 * t5)
    add a0 a0 t6  # a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1)

    jr ra
    
done:
    mv a1 a0
    li a0 1
    ecall