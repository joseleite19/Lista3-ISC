.data
ENTRADA: .word 3,3,3
SAIDA: .word 0,0,0,0,0,0
.text
	la $s0, ENTRADA 	#Carrega o valor do label ENTRADA no registrador $s0
	la $s1, SAIDA		#Carrega o valor do label SAIDA no registrador $s1
	lw $t1,0($s0)		#Carrega o valor do endereço $s0+0 no registrador $t1
	lw $t2,4($s0)		#Carrega o valor do endereço $s0+4 no registrador $t2
	lw $t3,8($s0)		#Carrega o valor do endereço $s0+8 no registrador $t3
	add $t4,$t1,$t2		#Soma o valor do registrador $t1 com $t2 e coloca o resultado em $t4
	add $t5,$t1,$t3		#Soma o valor do registrador $t1 com $t3 e coloca o resultado em $t5
	add $t6,$t2,$t3		#Soma o valor do registrador $t2 com $t3 e coloca o resultado em $t6
	blt $t4,$t3,ELSE	#A execução do código salta para linha indicada pelo label ELSE caso o valor de $t4 seja menor que o de $t3
	beq $t4,$t3,ELSE	#A execução do código salta para linha indicada pelo label ELSE caso o valor de $t4 seja igual ao de $t3
	blt $t5,$t2,ELSE	#A execução do código salta para linha indicada pelo label ELSE caso o valor de $t5 seja menor que o de $t2
	beq $t5,$t2,ELSE	#A execução do código salta para linha indicada pelo label ELSE caso o valor de $t5 seja igual ao de $t2
	blt $t6,$t1,ELSE	#A execução do código salta para linha indicada pelo label ELSE caso o valor de $t6 seja menor que o de $t1
	beq $t6,$t1,ELSE	#A execução do código salta para linha indicada pelo label ELSE caso o valor de $t6 seja igual ao de $t1
	addi $t7,$zero,1	#Coloca o valor 1 no registrador $t7
	sw $t7,0($s1)		#Armazena o valor de $t7 no endereço $s1+0
	beq $t1,$t2,ISOS	#A execução do código salta para linha indicada pelo label ISOS caso o valor de $t1 igual ao de $t2		
	beq $t1,$t3,ISOS	#A execução do código salta para linha indicada pelo label ISOS caso o valor de $t1 igual ao de $t3
	beq $t2,$t3,ISOS	#A execução do código salta para linha indicada pelo label ISOS caso o valor de $t2 igual ao de $t3
	addi $t7,$zero,3	#Coloca o valor 3 no registrador $t7
	sw $t7,4($s1)		#Armazena o valor de $t7 no endereço $s1+4
	j RET			#A execução do código salta para linha indicada pelo label RET
ISOS:	addi $t7,$zero,4	#Coloca o valor 4 no registrador $t7
	sw $t7,8($s1)		#Armazena o valor de $t7 no endereço $s1+8
	sub $t4,$t1,$t2		#Subtrai o valor do registrador $t2 de $t1 e coloca o resultado em $t4
	sub $t5,$t2,$t3		#Subtrai o valor do registrador $t3 de $t2 e coloca o resultado em $t5
	bne $t4,$zero,RET	#Verifica se o valor de $t4 é 0, caso não seja a execução do código salta para a linha indicada pelo label RET
	bne $t5,$zero,RET	#Verifica se o valor de $t5 é 0, caso não seja a execução do código salta para a linha indicada pelo label RET
	addi $t7,$zero,5	#Coloca o valor 5 no registrador $t7
	sw $t7,12($s1)		#Armazena o valor de $t7 no endereço $s1+12
RET:	mult $t1,$t1		#Multiplica $t1 por $t1 e coloca a parte menos significativa do resultado no registrador lo e a mais significativa no registrador hi
	mflo $t4		#Move o valor do registrador lo para $t4
	mult $t2,$t2		#Multiplica $t2 por $t2 e coloca a parte menos significativa do resultado no registrador lo e a mais significativa no registrador hi
	mflo $t5		#Move o valor do registrador lo para $t5
	mult $t3,$t3		#Multiplica $t2 por $t2 e coloca a parte menos significativa do resultado no registrador lo e a mais significativa no registrador hi
	mflo $t6		#Move o valor do registrador lo para $t6
	add $t1,$t4,$t5		#Soma o valor do registrador $t1 com $t4 e coloca o resultado em $t1
	add $t2,$t4,$t6		#Soma o valor do registrador $t2 com $t4 e coloca o resultado em $t2
	add $t3,$t5,$t6		#Soma o valor do registrador $t3 com $t5 e coloca o resultado em $t3
	beq $t6,$t1,SRET	#A execução do código salta para linha indicada pelo label SRET caso o valor de $t6 seja igual ao de $t1	
	beq $t5,$t2,SRET	#A execução do código salta para linha indicada pelo label SRET caso o valor de $t5 seja igual ao de $t2	
	beq $t4,$t3,SRET	#A execução do código salta para linha indicada pelo label SRET caso o valor de $t4 seja igual ao de $t3	
	j FIM			#A execução do código salta para linha indicada pelo label FIM
SRET:	addi $t7,$zero,6	#Coloca o valor 6 no registrador $t7
	sw $t7,16($s1)		#Armazena o valor de $t7 no endereço $s1+16
	j FIM			#A execução do código salta para linha indicada pelo label FIM
ELSE:	addi $t7,$zero,2	#Coloca o valor 2 no registrador $t7
	sw $t7,20($s1)		#Armazena o valor de $t7 no endereço $s1+20
FIM: