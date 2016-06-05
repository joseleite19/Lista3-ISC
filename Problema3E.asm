.data
ENTRADA: .word 2,40
SAIDA: .word 0
.text
	la $s0, ENTRADA			#Carrega o valor do endereço indicado pela label ENTRADA no registrador $s0
	la $s1, SAIDA			#Carrega o valor do endereço indicado pela label SAIDA no registrador $s1
	lw $t0,0($s0)			#Carrega o valor armazenado no endereço $s0+0 no registrador $t0
	lw $t1,4($s0)			#Carrega o valor armazenado no endereço $s0+0 no registrador $t1
	add $t2,$t0,$zero		#Coloca o valor do registrador $t0 no $t2
	addi $t3,$zero,6521 		#Coloca o valor	1000000007 no registrador $t3
	beq $t1,$zero,UM		#A execução do código salta para linha indicada pelo label UM caso o valor de $t1 seja igual a 0
	addi $t1,$t1,-1			#Subtrai 1 do valor do registrador $t1
	beq $t1,$zero,FIM		#A execução do código salta para linha indicada pelo label FIM caso o valor de $t1 seja igual a 0
LOOP:	mult $t2,$t0			#Multiplica o valor do registrador $t2 pelo de $t0 e coloca a parte menos significativa do resultado no registrador lo e a mais significativa no registrador hi
	mflo $t2			#Move o valor do registrador lo para o registrador $t2
	div $t2,$t3			#Divide o valor do registrador $t2 pelo de $t0 e coloca o resto da divisão no registrador hi e o quociente no registrador lo
	mfhi $t2			#Move o valor do registrador hi para o registrador $t2
	addi $t1,$t1,-1			#Subtrai 1 do valor do registrador $t1
	bne $t1,$zero,LOOP		#A execução do código salta para linha indicada pelo label LOOP caso o valor de $t1 seja diferente de 0
	j FIM				#A execução do código salta para linha indicada pelo label FIM
UM:	addi $t2,$zero,1		#Coloca o valor	1000000007 no registrador $t2
FIM:	sw $t2,0($s1)			#Armazena o valor de $t2 no endereço $s1+0
