.data 
.text

	li $t4,0xFF012C00
	li $s3,0xFF000000
	li $s1,0x07070707
LOOP: 	beq $s3,$t4,FORA
	sw $s1,0($s3)
	addi $s3,$s3,4
	j LOOP
FORA: 	
	li $t3,0xFF00014c
	li $s2,0xFF000140
	li $s1,0xb2b2b2b2
	move $t7,$s2 
	move $t5,$t3 #salva em $t5 o fim do endereço que sera printado
	move $s4,$t7  #salva em $t5 o inicio do endereço que sera printado
	li $t6,10
fica:	addi $t6,$t6,-1
	add $t3,$t3,0x00000140
	add $t7,$t7,0x00000140
	move $s2,$t7
LOOP3: 	beq $s2,$t3,FORA3
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP3
FORA3: 	bne $t6,$zero,fica
FIM:	# Leitura do teclado e echo na tela
	la $t1,0xFF100000
	li $t0,2
	sw $t0,0($t1)   # Habilita interrupção do teclado
	li $s0,0
CONTA:	addi $s0,$s0,1		# contador
 	j CONTA


.ktext
ECHO: 	la $t1,0xFF100000
   	lw $t2,4($t1)  # Tecla lida
	sw $t2,12($t1)
	beq $t2,0x64,direita
	beq $t2,0x73,baixo
	beq $t2,0x61,esquerda
	beq $t2,0x77,cima
fim:	eret
direita:li $t6,10
	move $t3,$t5
	move $t7,$s4
	addi $t3,$t3,0xc
	addi $t7,$t7,0xc
	li $s1,0x07070707
fica5:	addi $t6,$t6,-1 #parte dos 5 coloca vemelho onde tava azul
	add $t5,$t5,0x00000140
	add $s4,$s4,0x00000140
	move $s2,$s4
LOOP5: 	beq $s2,$t5,FORA5
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP5
FORA5:	bne $t6,$zero,fica5
	move $t5,$t3
	move $s4,$t7
	li $t6,10
	li $s1,0xb2b2b2b2 #parte dos 4 cria um novo quadrado azul
fica4:	addi $t6,$t6,-1
	add $t3,$t3,0x00000140
	add $t7,$t7,0x00000140
	move $s2,$t7
LOOP4: 	beq $s2,$t3,FORA4
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP4
FORA4:	bne $t6,$zero,fica4
	j fim #volta pra ler outra tecla, os pra esquerda, cima e baixo sao parecidos
baixo:	li $t6,10
	li $s1,0x07070707
	move $t3,$t5
	move $t7,$s4
	addi $t3,$t3,0xc80
	addi $t7,$t7,0xc80
fica6:	addi $t6,$t6,-1
	add $t5,$t5,0x00000140
	add $s4,$s4,0x00000140
	move $s2,$s4
LOOP6: 	beq $s2,$t5,FORA6
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP6
FORA6:	bne $t6,$zero,fica6
	li $t6,10
	li $s1,0xb2b2b2b2
fica8:	addi $t6,$t6,-1
	add $t3,$t3,0x00000140
	add $t7,$t7,0x00000140
	move $s2,$t7
LOOP8: 	beq $s2,$t3,FORA8
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP8
FORA8:	bne $t6,$zero,fica8
	j fim
cima:	li $t6,10
	li $s1,0x07070707
	move $t3,$t5
	move $t7,$s4
	addi $t3,$t3,-0xc80
	addi $t7,$t7,-0xc80
fica16:	addi $t6,$t6,-1
	add $t5,$t5,0x00000140
	add $s4,$s4,0x00000140
	move $s2,$s4
LOOP16: beq $s2,$t5,FORA16
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP16
FORA16:	bne $t6,$zero,fica16
	li $t6,10
	li $s1,0xb2b2b2b2
fica18:	addi $t6,$t6,-1
	add $t3,$t3,0x00000140
	add $t7,$t7,0x00000140
	move $s2,$t7
LOOP18: beq $s2,$t3,FORA18
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP18
FORA18:	bne $t6,$zero,fica18
	move $t5,$t3
	move $s4,$t7
	addi $t5,$t5,-0xc80
	addi $s4,$s4,-0xc80
	j fim
esquerda:li $t6,10
	move $t3,$t5
	move $t7,$s4
	addi $t3,$t3,-0xc
	addi $t7,$t7,-0xc
	li $s1,0x07070707
fica15:	addi $t6,$t6,-1
	add $t5,$t5,0x00000140
	add $s4,$s4,0x00000140
	move $s2,$s4
LOOP15: beq $s2,$t5,FORA15
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP5
FORA15:	bne $t6,$zero,fica15
	move $t5,$t3
	move $s4,$t7
	li $t6,10
	li $s1,0xb2b2b2b2
fica14:	addi $t6,$t6,-1
	add $t3,$t3,0x00000140
	add $t7,$t7,0x00000140
	move $s2,$t7
LOOP14:	beq $s2,$t3,FORA14
	sw $s1,0($s2)
	addi $s2,$s2,4
	j LOOP14
FORA14:	bne $t6,$zero,fica14
	j fim
