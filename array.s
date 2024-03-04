.data
arr1: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, # int arr1[10]
arr2: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, # int arr1[10]
newline: .string "\n"
.text
main:
    # Register not to be use x0 to x4 and x10 to x17
    # int size=10, i, sum1 = 0, sum2 = 0;
    li x5 10 # let x5 = size = 10
    li x6 0 # let x6 = sum1 = 0
    li x7 0 # let x7 = sum2 = 0
    
    # for( i = 0; i < size; i++) {
    #   arr1[i] = i+1;
    #}
    
    li x8 0 # let x8 = i = 0
    la x9 arr1 # loading the address of arr1 to x9
loop1:
    bge x8 x5 done1
    # we need to calculate $arr1[i]
    # we need the base address of arr1
    # then, we add an offset of (i*4) to the base address    
    slli x18, x8 2 # set x18 to (i*4)
    add x19 x18 x9 # add i*4 to the base addres off arr1 and put it to x19
    addi x20 x8 1 # set x20 to i + 1
    sw x20, 09(x19) # arr[i] = i + 1
    addi x8 x8 1 # i++
    j loop1

done1:
    addi x8 x0 0 # set i = 0
    la x21 arr2# loading address arr2 to x21
    
loop2:
    bge x8 x5 done2
    # we need to calculate &arr2[i]
    # we need the base address of arr2
    # then, we add an offset of (i*4) to the base address    
    slli x18, x8 2 # set x18 to (i*4)
    add x19 x18 x21 # add i*4 to the base addres off arr1 and put it to x21
    add x20 x8 x8 # set x20 to i + i = (2*i)
    sw x20, 09(x19) # arr[i] = i + i = (2*i)
    addi x8 x8 1 # i++
    j loop2  

done2:

addi x8 x0 0 # set i to 0
loop3:
    bge x8 x5 done3 # check if i >= size, if so done3
    # sum1 + arr1[i]
    # need adress of arr1[i]
    slli x18 x8 2 # set x18 =  i * 4
    add x19 x18 x9 # add i * 4 to the base addresss of arr1 and put it to x19
    lw x20, 0(x19) # x20 has arr1[i]
    add x6 x6 x20 # sum1 += arr1[i]
    # sum2 + arr2[i]
    #need adress of arr1[i]
    add x19 x18 x21 # add i*4 to the base address of arr2 and put it ot x19
    lw x20 0(x19) # x20 has arr2[i]
    add x7 x7 x20 # sum2 += arr2[i]
    addi x8 x8 1 # i++
    j loop3

done3:
    li a0 1
    add a1 zero x6
    ecall
    
    #print a new line character
    li a0 4
    la a1 newline
    ecall
    
     li a0 1
    add a1 zero x7
    ecall
    
    #print a new line character
    li a0 4
    la a1 newline
    ecall
    
    #exit
    li a0 10
    ecall