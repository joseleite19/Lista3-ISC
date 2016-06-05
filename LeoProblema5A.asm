.data
ENTRADA: 5, -10, 7, -13, -1, 52

.text	 
	la $t0, ENTRADA
	li $t7, 0			#Flag de para da programa
	lw $t1, ($t0)
	
	li $s0, -2147483648		#Máximo inicial
	li $s1, 2147483647		#Mínimo inicial
	addi $t0, $t0, 4				
VAI:	
	lw $t2, ($t0)
	beq $t7, $t1, FIM
	addi $t7, $t7, 1
	j COMPARE
	
	
COMPARE:
	bge $t2, $s0, MAX
	blt $t2, $s1, MIN
	 
MAX:
	add $s0, $t2, $0
	addi $t0, $t0, 4
	j VAI
MIN:
	add $s1, $t2, $0
	addi $t0, $t0, 4
	j VAI
FIM:
	