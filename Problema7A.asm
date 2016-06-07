.data
ENTRADA: .word 7,43,32,-99,1,12,43,54,1234,534,654,12,-32,42,-2
SAIDA: .word 2

.text
	la $t3,ENTRADA		#Armazena em $t3 o endereço da label ENTRADA
	la $s1,SAIDA		#Armazena em $s1 o endereço da label SAIDA
	lw $t0,0($t3)		#Armazena em $t0 o tamanho dos vetores
	add $t5,$t0,0		#Coloca o valor de $t0 em $t5
	sub $t1,$t0,$t0		#Coloca 0 em $t1
	sub $t7,$t0,$t0		#Coloca 0 em $t7
LOOP:	addi $t0,$t0,-1		
	addi $t3,$t3,4		
	addi $t1,$t1,4		
	lw $t4,0($t3)		#Armazena em $t4 um elemento do primeiro vetor
	addi $sp,$sp,-4		#Libera um espaço na pilha
	sw $t4,0($sp)		#Armazena na pilha o valor de $t4
	bne $t0,$zero, LOOP	#Condição para que sejam armazenador na pilha todos os elementos do primeiro vetor
	add $sp,$sp,$t1		#Volta a pilha para a posição incial
	add $sp,$sp,-4
LOOP2:	addi $t5,$t5,-1		
	addi $t3,$t3,4		
	lw $t4,0($t3)		#Armazena em $t4 o elemento na posição x do segundo vetor
	lw $t6,0($sp)		#Armazena em $t6 o elemento na posição x do primeiro vetor
	mult $t4,$t6		#Multiplica os elementos da posição x de cada vetor
	mflo $t4
	add $t7,$t4,$t7		#Soma as multiplicações dos elementos dos vetores
	addi $sp,$sp,-4
	bne $t5,$zero, LOOP2	#Condição para que todos os elementos dos vetores sejam multiplicados e somados
	add $sp,$sp,$t1
	add $sp,$sp,4
	sw $t7,0($s1)		#Armazena no endereço $s1+0 o resultado da soma das multiplicações dos elementos dos vetores