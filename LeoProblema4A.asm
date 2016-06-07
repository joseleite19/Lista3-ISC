.data
ENTRADA: .float 10, 10, 8, -1

SAIDA: .word 0

.text
	
	la $t0, ENTRADA
	
	li $t6, 1	
	
	lwc1 $f1, 0($t0)
	cvt.w.s $f10, $f2
	mfc1 $s1, $f10
	blt $s1, $0, MEDIA
	addi $t0, $t0, 4
	
	lwc1 $f2, 0($t0)
	cvt.w.s $f10, $f2
	mfc1 $s1, $f10
	blt $s1, $0, MEDIA
	addi $t0, $t0, 4
	add.s $f1, $f1,$f2
	addi $t6, $t6, 1
	
	lwc1 $f2, 0($t0)
	cvt.w.s $f10, $f2
	mfc1 $s1, $f10
	blt $s1, $0, MEDIA
	addi $t0, $t0, 4
	add.s $f1, $f1,$f2
	addi $t6, $t6, 1
	
	lwc1 $f2, 0($t0)
	cvt.w.s $f10, $f2
	mfc1 $s1, $f10
	blt $s1, $0, MEDIA
	addi $t0, $t0, 4
	addi $t6, $t6, 1
	
	lwc1 $f2, 0($t0)
	cvt.w.s $f10, $f2
	mfc1 $s1, $f10
	blt $s1, $0, MEDIA
	addi $t0, $t0, 4
	add.s $f1, $f1,$f2
	addi $t6, $t6, 1
	
	 	  	 
MEDIA:
	mtc1 $t6, $f6            #Move to Coprocessor 1 (FPU) : Set Coprocessor 1 register $f1 to value in $t1
	cvt.s.w $f6, $f6
	div.s $f0, $f1, $f6
	
	