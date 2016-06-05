.data
	ENTRADA: .word 1, 5, 3
	SAIDA: .word 0

.text
	# s0 = a; s1 = b; s2 = c
	la $t0, ENTRADA
	lw $s0, 0($t0)
	lw $s1, 4($t0)
	lw $s2, 8($t0)
	mul $t0, $s1, $s1
	mul $t1, $s0, $s2
	mul $t1, $t1, 4
	sub $t2, $t0, $t1 # delta = b*b - 4*a*c
	slt $t3, $t2, $zero
	bne $t3, $zero, else
	add $t4, $zero, 1
	j endif
else: 	add $t4, $zero, 2
	j endif	
endif:  la $t0, SAIDA
	sw $t4, 0($t0)