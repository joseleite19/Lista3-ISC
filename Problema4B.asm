.data
ENTRADA: .double -7,0,0,2142,5,0,0,0,999999 #f6,f8,f10,f12,f14,f16,f18,f2,f4
CONSTANTES: .double 0.000000001,0,2,1
EXPBASE: .double 0,0,0,0	#base,resultado da exponenciação
SAIDA: .double 2
.text
	#f2=a,f4=b,f6=p,f8=q,f10=r,f12=s,f14=i,f16=j,f18=k,f22=x
	j MAIN			#Chama a função MAIN
POW: 	ldc1 $f30,0($s1)	#Carrega em $f30 o valor da base
	ldc1 $f24,0($s1)	#Carrega em $f24 o valor da base
	c.eq.d 0,$f30,$f28	#Verifica se a base é zero
	bc1t FIM0
	blt $a1,$zero POWN1	#Verifica se o expoente é negativo ou positivo
	beq $a1,$zero POW0	#Verifica se o expoente é 0
POWP1:	beq $a1,$zero FIMP1	#Verifica se o expoente é  0
	mul.d $f30,$f30,$f24	#Multiplica $f30 por $f24 e coloca o resultado em $f30
	addi $a1,$a1,-1		#Decrementa o valor de $a1(expoente) em 1
	j POWP1			#Pula para o fim da potenciação com expoente positivo
POWN1:	beq $a1,$zero FIMN1	#Verifica se o expoente é diferente de 0
	mul.d $f30,$f30,$f24	#Multiplica $f30 por $f24 e coloca o resultado em $f30
	addi $a1,$a1,1		#Incrementa o valor de $a1(expoente) em 1
	j POWN1			#Pula para o fim da potenciação com expoente negativo
POW0:	add.d $f30,$f28,$f20
	sdc1 $f30,8($s1)	
	jr $ra	
FIMN1:	div.d $f30,$f30,$f24	#Divide $f30 por $f24 e coloca o resultado em $f30
	div.d $f30,$f20,$f30	#Divide 1 por $f30 e coloca o resultado em $f30
	sdc1 $f30,8($s1)	#Armazena o resultado da potenciação no endereço $s1+8
	jr $ra			#Retorna à função principal
FIMP1:	div.d $f30,$f30,$f24	#Divide $f30 por $f24 e coloca o resultado em $f30
	sdc1 $f30,8($s1)	#Armazena o resultado da potenciação no endereço $s1+8	
	jr $ra			#Retorna à função principal
FIM0:	sdc1 $f30,8($s1)
	jr $ra
MAIN:	la $s0,ENTRADA 		#Coloca o endereço da label ENTRADA no registrador $s0
	la $s1,EXPBASE 		#Coloca o endereço da label ENTRADA no registrador $s0
	la $s2,SAIDA 		#Coloca o endereço da label ENTRADA no registrador $s0
	la $s3,CONSTANTES	#Coloca o endereço da label ENTRADA no registrador $s0
	ldc1 $f0,0($s3)		#Coloca o valor no endereço $s3+0 no registrador $s1
	ldc1 $f2,56($s0)	#Coloca o valor no endereço $s0+56 no registrador $f2
	ldc1 $f4,64($s0)	#Coloca o valor no endereço $s0+64 no registrador $f4
	ldc1 $f6,0($s0)		#Coloca o valor no endereço $s0+0 no registrador $f6	
	ldc1 $f8,8($s0)		#Coloca o valor no endereço $s0+8 no registrador $f8
	ldc1 $f10,16($s0)	#Coloca o valor no endereço $s0+16 no registrador $f10
	ldc1 $f12,24($s0)	#Coloca o valor no endereço $s0+24 no registrador $f12
	ldc1 $f14,32($s0)	#Coloca o valor no endereço $s0+32 no registrador $f14
	ldc1 $f16,40($s0)	#Coloca o valor no endereço $s0+40 no registrador $f16
	ldc1 $f18,48($s0)	#Coloca o valor no endereço $s0+48 no registrador $f16
	ldc1 $f28,8($s3)	#Coloca o valor no endereço $s3+8 no registrador $f28
	ldc1 $f26,16($s3)	#Coloca o valor no endereço $s3+16 no registrador $f26
	ldc1 $f20,24($s3)	#Coloca o valor no endereço $s3+24 no registrador $f20
LOOP:	add.d $f22,$f2,$f4	#Coloca em $f22 o valor da soma de $f2 com $f4
	div.d $f22,$f22,$f26	#Coloca em $f22 o valor da divisão de $f22 por 2
	cvt.w.d $f14,$f14	#Converte o valor de $f14 para inteiro(word)	#Próxima potencia:p*(pow(a,i))
	mfc1 $t0,$f14		#Move o valor de $f14 para $t0
	add.d $f30,$f2,$f28	#Coloca o valor de $f2 em $f30
	sdc1 $f2,0($s1)		#Armazena o valor de $f2 no endereço $s1+0
	addi $a1,$t0,0		#Coloca o valor de $t0 em $a1
	jal POW			#Chama a função de potenciação
	mul.d $f30,$f30,$f6	#Multiplica $f30 por $f6 e coloca o resultado em $f30
	sdc1 $f30,16($s1)	#Armazena o resultado de p*(pow(a,i)) no endereço $s1+16
	cvt.w.d $f16,$f16	#Converte o valor de $f14 para inteiro(word)	#Próxima potencia:q*(pow(a,j))
	mfc1 $t0,$f16		#Coloca o valor de $f16 em $t0
	add.d $f30,$f2,$f28	#Coloca o valor de $f2 em $f30
	sdc1 $f2,0($s1)		#Armazena ov valor de $f2 no endereço $s1+0
	addi $a1,$t0,0		#Coloca o valor de $t0 em $a1
	jal POW			#Chama a função POW
	mul.d $f30,$f30,$f8	#Multiplica $f30 por $f8 e coloca o resultado em $f30
	ldc1 $f24,16($s1)	#Carrega o resultado armazenado no endereço $s1+16 em $f24
	add.d $f30,$f30,$f24	#Soma o valor de $f30 com $f24 e armazena o resultado em $f30
	sdc1 $f30,16($s1)	#Armazena o resultado de p*(pow(a,i))+q*(pow(a,j)) no endereço $s1+16
	cvt.w.d $f18,$f18	#Converte o valor de $f18 para inteiro(word)		#Próxima potencia:r*(pow(a,k))
	mfc1 $t0,$f18		#Move o valor de $f18 para $t0
	add.d $f30,$f2,$f28	#Coloca o valor de $f2 em $f30
	sdc1 $f2,0($s1)		#Armazena o valor de $f2 no endereço $s1+0
	addi $a1,$t0,0		#Coloca o valor de $t0 em $a1
	jal POW			#Chama a função POW
	mul.d $f30,$f30,$f10	#Multiplica $f30 por $f10 e coloca o resultado em $f30
	ldc1 $f24,16($s1)	#Carrega o resultado armazenado no endereço $s1+16 em $f24
	add.d $f30,$f30,$f24	#Soma o valor de $f30 com $f24 e armazena o resultado em $f30
	add.d $f30,$f30,$f12	#Soma o valor de $f30 com $f12 e armazena o resultado em $f30
	sdc1 $f30,16($s1)	#Armazena o resultado no endereço $s1+16
	cvt.w.d $f14,$f14	#Próxima potencia:p*(pow(x,i))
	mfc1 $t0,$f14
	add.d $f30,$f22,$f28
	sdc1 $f22,0($s1)
	addi $a1,$t0,0
	jal POW			#Chama a função POW
	mul.d $f30,$f30,$f6
	sdc1 $f30,24($s1)
	cvt.w.d $f16,$f16	#Próxima potencia:q*(pow(x,j))
	mfc1 $t0,$f16
	add.d $f30,$f22,$f28
	sdc1 $f22,0($s1)
	addi $a1,$t0,0
	jal POW			#Chama a função POW
	mul.d $f30,$f30,$f8
	ldc1 $f24,24($s1)
	add.d $f30,$f30,$f24	
	sdc1 $f30,24($s1)
	cvt.w.d $f18,$f18	#Próxima potencia:r*(pow(x,k))
	mfc1 $t0,$f18
	add.d $f30,$f22,$f28
	sdc1 $f22,0($s1)
	addi $a1,$t0,0
	jal POW			#Chama a função POW
	mul.d $f30,$f30,$f10
	ldc1 $f24,24($s1)
	add.d $f30,$f30,$f24	
	add.d $f30,$f30,$f12
	ldc1 $f24,16($s1)
	mul.d $f30,$f30,$f24 	#Armazena ((p*pow(a,i)+q*pow(a,j)+r*pow(a,k)+s)*(p*pow(x,i)+q*pow(x,j)+r*pow(x,k)+s)) em $f30
	sdc1 $f30,24($s1)
	c.lt.d 0,$f30,$f28	#
	bc1f ELSE
	add.d $f4,$f22,$f28
	j FELSE
ELSE:	add.d $f2,$f22,$f28
FELSE:	sub.d $f24,$f4,$f2
	c.lt.d 0,$f0,$f24
	bc1t  LOOP
	add.d $f2,$f2,$f4
	div.d $f2,$f2,$f26
	sdc1 $f2,0($s2)
