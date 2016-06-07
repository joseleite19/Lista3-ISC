.data
ENTRADA: .double 10,5,5,2,3,4
SAIDA: .double 2
.text
	la $s0,ENTRADA 		#Coloca o endereço da label ENTRADA no registrador $s0
	ldc1 $f0,0($s0)		#Coloca o valor no endereço $s0+0 no registrador $f0
	ldc1 $f2,8($s0)		#Coloca o valor no endereço $s0+8 no registrador $f2
	ldc1 $f4,16($s0)	#Coloca o valor no endereço $s0+16 no registrador $f4
	ldc1 $f6,24($s0)	#Coloca o valor no endereço $s0+24 no registrador $f6	
	ldc1 $f8,32($s0)	#Coloca o valor no endereço $s0+32 no registrador $f8
	ldc1 $f10,40($s0)	#Coloca o valor no endereço $s0+40 no registrador $f10
	mul.d $f12,$f0,$f6	#Multiplica os valores dos registradores $f0 e $f6 e coloca o resultado no registrador $f12
	mul.d $f14,$f2,$f8	#Multiplica os valores dos registradores $f2 e $f8 e coloca o resultado no registrador $f14
	mul.d $f16,$f4,$f10	#Multiplica os valores dos registradores $f4 e $f10 e coloca o resultado no registrador $f16
	add.d $f6,$f6,$f8	#Soma os valores dos registradores $f6 e $f8 e coloca o resultado no registrador $f6	
	add.d $f6,$f6,$f10	#Soma os valores dos registradores $f6 e $f10 e coloca o resultado no registrador $f6	
	add.d $f12,$f12,$f14	#Soma os valores dos registradores $f12 e $f14 e coloca o resultado no registrador $f12	
	add.d $f12,$f12,$f16	#Soma os valores dos registradores $f12 e $f16 e coloca o resultado no registrador $f12	
	la $s1,SAIDA		#Coloca o endereço da label SAIDA no registrador $s1
	div.d $f12,$f12,$f6	#Divide os valores do registrador $f12 por $f6 e coloca o resultado no registrador $f12		
	sdc1 $f12,0($s1)	#Armazera o valor de $f12 no endereço $s1+0
