#gcd assembly code

.data
N1:     .word 4
N2:     .word 8
str1:   .string "GCD value of "
str2:   .string " and "
str3:   .string " is "

.text
main:
        lw      a0, N1
	lw	a1, N2
	jal	ra, GCD

	mv	a2, a0
	lw	a0, N1
	lw	a1, N2
	jal	ra, printResult

	li	a7, 10
	ecall

GCD:
	beq     a1, zero, exit
        addi	sp, sp, -24
	sw	ra, 0(sp)
        sw      a0, 8(sp)
        sw      a1, 16(sp)
	j       nGCD
	
exit:
        ret

nGCD:
        lw      a1, 8(sp)
        lw      a0, 16(sp)
	rem	a1, a1, a0
	jal	ra, GCD
	lw	ra, 0(sp)
	addi	sp, sp, 24
	ret

printResult:
	mv	t0, a0
	mv	t1, a1
	mv	t2, a2

	la	a0, str1 
	li	a7, 4
	ecall

	mv	a0, t0
	li	a7, 1
	ecall

	la	a0, str2
	li	a7, 4
	ecall

	mv	a0, t1
	li	a7, 1
	ecall

	la	a0, str3
	li	a7, 4
	ecall

	mv	a0, t2
	li	a7, 1
	ecall

	ret