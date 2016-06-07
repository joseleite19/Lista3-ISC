.data

ENTRADA: .word 4, 5, 5, -7, 4, 6, 2, 0, 5, 5, 6
SAIDA: .word 0:10

VETORZAO: .word 0:10
VETORAUX: .word 0:10

.text
	# s0 = n; s1 = q;s2 = VETORZAO; s3 = VETORAUX
	j main

buscab:	blt $a1,$a3,fim1
	add $t4,$a1,$a3
	div $t4,$t5
	mflo $t6
	add $t4,$t6,$zero
	mult $t4,$t5
	mflo $t4
	mult $t4,$t5
	mflo $t4
	sub $sp,$sp,$t4	
	lw $t7,0($sp)
	beq $t7,$a2,fim2
	blt $t7,$a2,cont
	addi $a1,$t6,-1
	add $sp,$sp,$t4
	j buscab
cont:	addi $a3,$t6,1
	add $sp,$sp,$t4
	j buscab
	
fim1:	li $v0, 0
	jr $ra
	
fim2:	li $v0, 1
	jr $ra

merge:	# t0 = i; t1 = j; t2 = k; t3 = meio
	move $t0, $a1
	li $t2, 0
	
	add $t3, $a1, $a2
	div $t3, $t3, 2
	
	move $t1, $t3

loopij:	beq $t0, $t3, loopi
	beq $t1, $a2, loopi
	sll $t4, $t0, 2
	add $t4, $t4, $s2
	
	sll $t5, $t1, 2
	add $t5, $t5, $s2
	
	sll $t6, $t2, 2
	add $t6, $t6, $s3
	
	lw $t7, ($t4)
	lw $t8, ($t5)
	
	slt $t9, $t7, $t8 # se v[i] < v[j]
	
	beq $t9, $zero, elseii

	sw $t7, ($t6)
	
	add $t2, $t2, 1
	add $t0, $t0, 1
	j loopij
elseii:	sw $t8, ($t6)
	
	add $t2, $t2, 1
	add $t1, $t1, 1
	
	j loopij

loopi:  beq $t0, $t3, endi
	sll $t4, $t0, 2
	add $t4, $t4, $s2
	
	sll $t6, $t2, 2
	add $t6, $t6, $s3
	
	lw $t7, ($t4)
	sw $t7, ($t6)
	
	add $t0, $t0, 1
	add $t2, $t2, 1
	j loopi
endi:
loopj:	beq $t1, $a2, endj
	sll $t4, $t1, 2
	add $t4, $t4, $s2
	
	sll $t6, $t2, 2
	add $t6, $t6, $s3
	
	lw $t7, ($t4)
	sw $t7, ($t6)
	
	add $t1, $t1, 1
	add $t2, $t2, 1
	j loopj

endj:	move $t0, $a1
loopfinal:
	beq $t0, $a2, endloopfinal
	sub $t1, $t0, $a1
	
	sll $t2, $t0, 2
	add $t2, $t2, $s2

	sll $t3, $t1, 2
	add $t3, $t3, $s3
	
	lw $t4, ($t3)
	sw $t4, ($t2)
	
	add $t0, $t0, 1
	j loopfinal
endloopfinal:
	j voltadomerge

	# a1 = indice inicio; a2 = indice fim; a3 = estado
mergesort:
	sub $t0, $a2, $a1
	sle $t0, $t0, 1
	bne $t0, $zero, pop
	
	li $t5, 2
	beq $a3, $t5, merge
	
	sub $sp, $sp, 4 	# push de a1, a2, e a3 na pilha
	sw $a1, 0($sp)
	sub $sp, $sp, 4
	sw $a2, 0($sp)
	sub $sp, $sp, 4
	sw $a3, 0($sp)	
	
	add $t0, $a1, $a2
	div $t0, $t0, 2
	
	bne $a3, $zero, else
	
	move $t1, $a1
	move $t2, $t0 
	j endif

else:	move $t1, $t0
	move $t2, $a2

endif:	move $a1, $t1
	move $a2, $t2
	li $a3, 0
	
	j mergesort

voltadomerge:
	bne $a2, $s0, pop
	li $t8, 2
	bne $a3, $t8, pop
	bne $a1, $zero, pop
	
	j back
	
pop:	lw $a3, ($sp)
	add $sp, $sp, 4
	lw $a2, ($sp)
	add $sp, $sp, 4
	lw $a1, ($sp)
	add $sp, $sp, 4
	
	add $a3, $a3, 1

	j mergesort

main:	la $t0, ENTRADA
	la $s2, VETORZAO
	la $s3, VETORAUX

	lw $s0, ($t0)
	lw $s1, 4($t0)
	
	add $t0, $t0, 8
	
	li $t9, 0
loop1:	sll $t1, $t9, 2
	
	add $t2, $t0, $t1
	add $t3, $s2, $t1
	
	lw $t4, ($t2)
	sw $t4, ($t3)
	
	add $t9, $t9, 1	
	
	bne $t9, $s0, loop1

	move $a2, $s0
	li $a1, 0
	j mergesort
back:	li $t9, 0
loop30:	lw $t2,($s2)
	addi $s2,$s2,4
	addi $sp,$sp,-4
	sw $t2, ($sp)
	
	add $t9, $t9, 1
	bne $t9, $s0, loop30
	sll $t0, $s0, 2
	
	add $sp, $sp, $t0

	li $t9, 0
	la $s4, ENTRADA
	la $s5, SAIDA
	sll $t0, $s0, 2
	add $s4, $s4, $t0
loopfinal2:
	lw $t0, ($s4)
	
	move $a2, $t0
	move $a1, $s0
	li $a3, 0
	li $t5, 2

	jal buscab
	sw $v0, ($s5)
	add $s5, $s5, 4

	add $t9, $t9, 1
	bne $t9, $s1, loopfinal2