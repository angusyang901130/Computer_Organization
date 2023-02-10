#fibonacci assembly code

.data
N:  .word 7      #fibonacci for 7th element
str1:      .string "th number in the Fibonacci sequence is "

.text
main:
        lw      a0, N
        jal     ra, Fibonacci

        #print the result to console
        mv      a1, a0
        lw      a0, N
        jal     ra, printResult

        #exit program
        li      a7, 10
        ecall

Fibonacci:
        addi    t0, zero, 1
        ble     a0, t0, exit

        addi    sp, sp, -24
        sw      ra, 8(sp)       
        sw      a0, 0(sp)       
        j       rFibonacci 

exit:
        ret

rFibonacci:
        addi    a0, a0, -1
        jal     ra, Fibonacci
        sw      a0, 16(sp)      #store static data

        lw      a0, 0(sp)
        addi    a0, a0, -2
        jal     ra, Fibonacci
        
        lw      ra, 8(sp)
        lw      t1, 16(sp)
        addi    sp, sp, 24

        add     a0, a0, t1
        ret

printResult:
        mv      t0, a0
        mv      t1, a1
        mv      a0, t0
        li      a7, 1
        ecall
        la      a0, str1
        li      a7, 4
        ecall
        mv      a0, t1
        li      a7, 1
        ecall
        ret