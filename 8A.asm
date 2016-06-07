.data

ENTRADA: .word 4, 5, 5, 7, -4, 6

VETORZAO: .word 0:100000
VETORAUX: .word 0:100000
SAIDA: .word 0:100000

.text
	# s0 = n; s1 = q;s2 = VETORZAO; s3 = VETORAUX
	j main


merge:	# t0 = i; t1 = j; t2 = k; t3 = meio
	move $t0, $a1
	li $t2, 0
	
	add $t3, $a1, $a2
	div $t3, $t3, 2
	
	move $t1, $t3

loopij:	sll $t4, $t0, 2
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
	bne $t0, $t3, loopij
	bne $t1, $a2, loopij
	j loopi
elseii:	sw $t8, ($t6)
	
	add $t2, $t2, 1
	add $t1, $t1, 1
	
	bne $t0, $t3, loopij
	bne $t1, $a2, loopij
	j loopi

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
	sle $t0, $t0, 2
	bne $t0, $zero, pop
	
	li $t5, 2
	sub $t9, $a2, $a1
	ble $t9, $t5, merge
	
	sub $sp, $sp, 4 	# push de a1, a2, e a3 na pilha
	sw $a1, ($sp)
	sub $sp, $sp, 4
	sw $a2, ($sp)
	sub $sp, $sp, 4
	sw $a3, ($sp)	
	
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
	
	
pop:	lw $a1, ($sp)
	add $sp, $sp, 4
	lw $a2, ($sp)
	add $sp, $sp, 4
	lw $a3, ($sp)
	add $sp, $sp, 4
	
	add $a3, $a3, 1
	
	bne $a2, $s0, recursao
	li $t8, 2
	bne $a3, $t8, recursao
	j back
recursao:
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
back:
	