.data
ENTRADA: .float 6,8		#Catetos
SAIDA: .float 0			#Hipotenusa
.text
	la $t0,ENTRADA
	lwc1 $f0, 0($t0)	#Carrega em '$f01'
	lwc1 $f1, 4($t0)	#Carrega em '$f1'
	la $t0, SAIDA		#Carrega o endereço de 'SAIDA' em $t0
	mul.s $f0, $f0, $f0	
	mul.s $f1, $f1, $f1
	add.s $f0, $f0, $f1
	sqrt.s  $f1, $f0
	swc1 $f1, SAIDA
