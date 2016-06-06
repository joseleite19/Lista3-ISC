.data
entrada: .word 6,3,1,2,3,4,5,6
saida: .word 0
.text
# d=$a1,e=$a3
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
	
fim1:	addi $v0,$zero,-1
	jr $ra
	
fim2:	addi $v0,$t4,0
	jr $ra
	
main:	la $s0,entrada
	la $s1,saida
	lw $t0,0($s0)
	lw $t1,4($s0)
	addi $s0,$s0,8
	addi $t3,$t0,-1
	lui $t6,0
	
loop:	lw $t2,0($s0)
	addi $s0,$s0,4
	addi $t0,$t0,-1
	addi $sp,$sp,-4
	addi $t6,$t6,4
	sw $t2,0($sp)
	bne $t0,0,loop
	add $sp,$sp,$t6
	
	addi $a1,$t3,0
	addi $a2,$t1,0
	addi $a3,$zero,0
	addi $t5,$zero,2
	jal buscab
	sw $v0,0($s1)
	
	