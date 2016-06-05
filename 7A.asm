.data
ENTRADA:.word 4, -2, 0, 1, 3, 1, 2, -2, 0
SAIDA:  .word 0
VETORU: .word 0:100000
VETORV: .word 0:100000

.text
	j Main	

LeEntrada:	# label responsável por ler $s0 words a partir do endereço em $t8 e salvar isso a apartir do endereço em $t7
		# usa o $t9 como contador auxiliar (assume que quando loop é chamado seu valor é 0)
		# como n >= 1 com certeze iremos ler ao menos 1 elemento

	sll $t0, $t9, 2		# calcula o deslocamento em bytes dos elementos
	
	add $t1, $t0, $t8	# calcula o endereço do elemento a ser lido
	add $t2, $t0, $t7	# calcula o endereço para salvar o elementos lido
	
	lw $t3, ($t1)		# lê a $t9-ésima coordenada
	sw $t3, ($t2)		# e salva na label de seu vetor
	
	add $t9, $t9, 1
	bne $t9, $s0, LeEntrada
	jr $ra

Main:	# $s0 = n; $s1 = endereço pra label VETORU; $s2 = endereço pra label VETORV
	
	la $s3, ENTRADA		# salva os 
	la $s1, VETORU		# endereços das labels 
	la $s2, VETORV		# ENTRADA, VETORU E VETOR V
	
	lw $s0, 0($s3) # le n da entrada
	
	add $t8, $s3, 4		# ajusta $t8 para ter o endereço do começo das coodenadas do primeiro vetor
	move $t7, $s1
	li $t9, 0
	
	jal LeEntrada		# le as coordenadas do vetor u
	
	add $t0, $s0, 1
	sll $t0, $t0, 2
	add $t8, $s3, $t0	# ajusta $t8 para ter o endereço do começo das coodenadas do segundo vetor
	move $t7, $s2
	li $t9, 0
	
	jal LeEntrada		# le as coordenadas do vetor v
	
	li $t9, 0
	li $t8, 0		# $t8 funcionará como um acumulador que vai guardar o produto escalar
				# a medida em que é calculado

loop:   beq $t9, $s0 endloop
	sll $t0, $t9, 2
	add $t1, $t0, $s1
	add $t2, $t0, $s2
	
	lw $t3, ($t1)
	lw $t4, ($t2)
	
	mul $t0, $t3, $t4
	
	add $t8, $t8, $t0
	
	add $t9, $t9, 1
	j loop
endloop:
	la $t0, SAIDA
	sw $t8, 0($t0)