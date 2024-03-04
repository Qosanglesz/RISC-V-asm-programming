# #include <stdio.h>

# void print_array(int A[], int size) {
#    int i;
#    for (i=0; i<size; i++)
#        printf("%d ", A[i]);
#    printf("\n");

#}

#int A[5] = {11, 22, 33, 44, 55};

#int main() {

#    print_array(A, 5);

#    return 0;
#}

.data
A: .word 11, 22, 33, 44, 55
B: .word 11, 22, 33, 44, 55, 66, 77, 88, 99, 1234
newline: .string "\n"
space: .string " "

.text
main:
    la a0, B # loading the starting address of array A to a0
    addi a1, x0, 10 # passing the array size value to a1
    jal print_array
    
    # exit cleanly
    addi a0, x0, 10
    ecall

print_array:
    addi t0, x0, 0 # let the i value be in t0
loop1:
    bge t0, a1, exit1
    slli t1, t0, 2 # t1 has the i*4 value
    add t2, t1, a0
    lw t3, 0(t2) # t3 has the value of A[i]
    
    # print A[i]
    
    # save a0 and a1 on to the stack; caller save as ecall realizes that a0 and a1 needed after the call
    addi sp, sp, -8
    sw a0, 0(sp)
    sw a1, 4(sp)
    addi a0, x0, 1
    mv a1, t3
    ecall

    # print space
    addi a0, x0, 4
    la a1, space
    ecall
    
    # restoring a0 and a1
    lw a0, 0(sp)
    lw a1, 4(sp)
    addi sp, sp, 8
    
    addi t0, t0, 1 # i++
    j loop1
    
exit1:
    # print newline
    addi a0, x0, 4
    la a1, newline
    ecall
    
    jr ra