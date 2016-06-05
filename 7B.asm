.data
ENTRADA: .word 5, 1, 4, 5, 9, 15
SAIDA:	 .word 0
VETOR:	 .word 0:1000

.text
	la $t0, ENTRADA
	la $t6, VETOR
	lw $s0, 0($t0)		# salva n
	add $t0, $t0, 4		# ajusta o endereço salvo em $t0 para que seja o do primeiro elemento a ser lido(depois de n)
	
	li $t9, 0		# $t9 serve como indice ler e armazenar os elementos na mesma ordem
	
loop1:	beq $t9, $s0, endloop1
	sll $t1, $t9, 2 	# calcula o deslocamento do endereço do proximo numero a ser lido/salvo
	add $t2, $t1, $t0	# calcula o endereço do proximo numero a ser lido
	add $t3, $t1, $t6	# calcula o endereço do proximo numero a ser salvo(em VETOR)
	
	lw $t4, ($t2)		# le o $t9-ésimo datagrama
	sw $t4, ($t3)		# salva o $t9-ésimo datagrama
	
	add $t9, $t9, 1		# incrementa o contador
	
	j loop1
endloop1:
	li $t7, 0 		# registrador acumulador, guardará o numero de inversões
	li $t9, 0
	
loop2:	beq $t9, $s0, endloop2

	sll $t1, $t9, 2
	add $t1, $t1, $t6	# ajusta $t1 para o endereço do $t9-ésimo elemento
	lw $t0, 0($t1)		# le a o $t9-ésimo elemento de VETOR
	
	add $t8, $t9, 1		# ajusta $t8 para sempre ser maior que $t9

loop3:	beq $t8, $s0, endloop3
	sll $t1, $t8, 2
	add $t1, $t1, $t6 	# ajusta $t1 para o endereço do $t8-ésimo elemento
	lw $t1, 0($t1)		# le a o $t8-ésimo elemento de VETOR
	
	slt $t2, $t1, $t0
	beq $t2, $zero, afterincrement
	add $t7, $t7, 1		# se ($t1) < ($t0) como $t1 > $t0, computamos +1 inversão
afterincrement:
	add $t8, $t8, 1		# incremento em $t8
	j loop3
endloop3:
	add $t9, $t9, 1		# incremento em $t9
	j loop2
endloop2:
	la $t0, SAIDA
	sw $t7, 0($t0)		# salvo o resultado em SAIDA