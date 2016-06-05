.data
ENTRADA: .word 10
SAIDA: .word 0:1000000

.text
	la $t0, ENTRADA
	lw $s0, 0($t0) 		# ler n da ENTRADA

	li $t1, 1
	li $t2, 2
	la $s1, SAIDA		# s1 aponta pro vetor de saida
	sw $t1, 0($s1)		# salva os 2 primeiros valores na saida (1 e 2)
	sw $t2, 4($s1)		# é possivel fazer isso sem um teste pois n >= 2 
	
	li $t8, 2		# t8 vai guardar o indice i na SAIDA

	j LOOP
LOOP:   beq $t8, $s0, done	# ""while""(i != n)
	sll $t1, $t8, 2		# calcula o "indice" em bytes, ou seja,  i << 2
	sub $t2, $t1, 4		# calcula indice i-1
	sub $t3, $t1, 8		# calcula indice i-2
	add $t4, $s1, $t1	# calcula o endereço do elemento de indice i
	add $t5, $s1, $t2	# calcula o endereço do elemento de indice (i - 1)
	add $t6, $s1, $t3	# calcula o endereço do elemento de indice (i - 2)
	
	lw $t1, ($t5)		# pega o (i-1)-ésimo elemento
	lw $t2, ($t6)		# pega o (i-2)-ésimo elemento
	
	add $t1, $t1, $t2 	# soma os (i-1)-ésimo e (i-2)-esimo elementos
	sub $t1, $t1, 1		# subtrai 1 da soma
	
	sw $t1, ($t4) 		# guarda o resultado no endereço do i-ésimo elemento
	
	add $t8, $t8, 1		# i++
	j loop			# end while
DONE:				#label para onde o programa segue depois de sair do loop