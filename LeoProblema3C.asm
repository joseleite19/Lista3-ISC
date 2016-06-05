.data
ENTRADA: 10

	
SAIDA: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	

.text
	la $t9, SAIDA
	sub $t0, $t0, $t0		#Reseta $t0
	sub $t1, $t1, $t1		#Idem. [Usado como o 'i'.]
	sub $t2, $t2, $t2		#Idem
	sub $t5, $t5, $t5
	addi $t5, $t5, 1		#$t5 vale 1. $t5 == 'an1'
	sub $t6, $t6, $t6
	addi $t6, $t6, 2		#$t6 vale 2. $t6 == 'an2'
	addi $t0, $t0, 1000000007	#Número que vai ser usado como divisor p/ aritmética modular
	la $t2, ENTRADA
	addi $t3, $t2, -2
	#la $t8, DEIVIS
	#jal DEIVIS
DEIVIS:
	slt $t4, $t1, $t3
	beqz $t4, SAIDA		# Se $t4 == 0, vai para o label 'ACABOU'.
	add $t7, $t5, $t6		
	addi $t7, $t7, -1		# Finalmente, $t7 vale 'Aux'
	div $t7, $t0			# Deixa o quociente de t7/t0 salvo em HI e o resto em Lo. Pegaremos este resto...
	mflo $t7			# Porém o dado está no formato float. É preciso converter isso para word
	swc1 $f0,($t7)		
	cvt.w.s $f1, $f0				
			
	add $t5, $t6, $0		# Salva o valor de $t6 em $t5
	#lwc1 $f0, ($t7)
	#cvt.w.s $f1, $f0		# Convertido de float para word
	#mfc1  $t7, $f1			# 'Aux' está pronto.Basta copiá-lo para 'an2'
	addi $t6, $t7, 0 		# Salva 'Aux' em $t6
	addi $t1, $t1, 1
	j DEIVIS
	
	####### O resultado deve estar no registrador $t6 #######

	
	
