#fibonacci assembly 

.data
argument:  .word 7      #fibonacci for 7th element
str1:      .string "th number in the Fibonacci sequence is "

.text
main:
        lw      a0, argument
        jal     ra, Fibonacci

        #print the result to console
        mv      a1, a0
        lw      a0, argument
        jal     ra, printResult

        #exit program
        li      a7, 10
        ecall

Fibonacci:
        addi    sp, sp, -16
        sw      ra, 8(sp)
        sw      a0, 0(sp)
        addi    t0, a0, -1
        bgt     t0, zero, rFibonacci 
        
        addi    a0, t1, 1
        addi    sp, sp, 16
        jr x1

rFibonacci:
        addi    a0, a0, -1
        jal     ra, Fibonacci
        addi    a1, a0, 0

        lw      a0, 0(sp)
        addi    a0, a0, -2
        jal     ra, Fibonacci
        
        lw      ra, 8(sp)
        addi    sp, sp, 16

        add     a0, a0, a1
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