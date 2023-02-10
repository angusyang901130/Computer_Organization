#bubble sort assembly code

.data
N:      .word   10
data:   .word   5, 3, 6, 7, 31, 23, 43, 12, 45, 1
str1:   .string "Array： "
str2:   .string "Sorted： "
endl:   .string "\n"
space:  .string " "    

.text
main:
        la      s0, data

        lw      a0, N
        la      a1, str1
        jal     ra, printResult

        lw      a0, N
        jal     ra, bubblesort

        lw      a0, N
        la      a1, str2
        jal     ra, printResult

        li      a7, 10
        ecall     

printResult:
        mv      a2, a0
        mv      a0, a1
        li      a7, 4
        ecall

        la      a0, endl
        li      a7, 4
        ecall

        mv      a0, a2
        j       printArray  

printArray:
        addi    a1, a0, 0
        addi    t0, zero, 0
        j       printnum
        
printnum:
        bge     t0, a1, endprint
        mv      a0, t0

        slli    t1, t0, 2
        add     s1, s0, t1

        lw      a0, 0(s1)
        li      a7, 1
        ecall

        la      a0, space
        li      a7, 4
        ecall

        addi    t0, t0, 1
        beq     t0, t0, printnum
        
endprint:
        la      a0, endl
        li      a7, 4
        ecall
        ret

bubblesort: 
        mv      a1, a0
        mv      t0, zero
        j       out_loop
        jr      x1

out_loop:
        addi    t1, t0, -1
        
        blt     t0, a1, in_loop
        ret     

in_loop:
        blt     t1, zero, exit
        slli    t2, t1, 2
        add     s1, s0, t2
        lw      t3, 0(s1)
        lw      t4, 4(s1)
        bgt     t3, t4, swap
        ble     t3, t4, exit

exit:
        addi    t0, t0, 1
        j       out_loop

swap:
        mv      t5, t3  
        sw      t3, 4(s1)
        sw      t4, 0(s1)
        addi    t1, t1, -1
        j       in_loop      