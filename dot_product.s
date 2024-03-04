# #include <stdio.h>

# int a[5] = {1, 2, 3, 4, 5};
# int b[5] = {6, 7, 8, 9, 10};

# int main() {
#    int i, sop = 0;
    
#    for (i = 0; i < 5; i++) {
#        sop += a[i] * b[i];
#    }
    
#    printf("The dot product is: %d\n", sop);
#    return 0;
#}

.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10

.text
li s0 0 #  i = 0
li s1 0 #  sop = 0
li t0 5 # t0 = 5
la s2 a
la s3 b
loop:
    bge s0 t0 done1
    slli t1 s0 2 # t1 = ( i = i*4)
    add t2 t1 s2 # add offset of a
    add t3 t1 s3 # add offset of b
    lw s4 0(t2) # s4 = a[i]
    lw s5 0(t3) # s5 = a[i]
    mul t4 s4 s5 # t4 = a[i] * b[i]
    add s1 s1 t4 # sop += a[i] & b[i] or t4
    addi s0 s0 1 # i++
    j loop
    
done1:
# print sop
    li a0 1
    add a1 zero s1
    ecall
# exist
    li a0 10
    ecall
    