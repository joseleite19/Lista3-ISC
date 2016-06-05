####################################################Calcula se dois vetores são ortogonais############################################

.data	
ENTRADA:	
	.word 4, -2, 0, 1, 13, 1, 2, -2, 0
.text

		la $t0, ENTRADA
		li $t1, 4
		lw $s0, 0($t0)		#SALVAR o diferença de endereços entre as entradas
		mul $s1, $s0, $t1 	#Esse será o quanto terá que se pular pra pegar o 1º elementoA e o 1º elementoB
		li $t7, 0		#Flag para o programa parar
		li $s2, 0		#Aqui ficará guardado o resultado final
VAI:
		addi $t0, $t0, 4
		beq $t7, $s0, FIM
		addi $t7, $t7, 1
		j MULTIPLY
MULTIPLY:
		lw $t2, 0($t0)
		add $t4, $t0, $s1
		lw $t3, 0($t4)
		mul $t5, $t2, $t3
		add $s2, $s2, $t5
		j VAI

FIM:					
		
		