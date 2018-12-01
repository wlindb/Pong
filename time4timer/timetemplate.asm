  # timetemplate.asm
  # Written 2015 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

.macro	PUSH (%reg)
	addi	$sp,$sp,-4
	sw	%reg,0($sp)
.end_macro

.macro	POP (%reg)
	lw	%reg,0($sp)
	addi	$sp,$sp,4
.end_macro

	.data
	.align 2
mytime:	.word 0x5957
timstr:	.ascii "text more text lots of text\0"
	.text
main:
	# print timstr
	la	$a0,timstr
	li	$v0,4
	syscall
	nop
	# wait a little
	li	$a0,1000
	jal	delay
	nop
	# call tick
	la	$a0,mytime
	jal	tick
	nop
	# call your function time2string
	la	$a0,timstr
	la	$t0,mytime
	lw	$a1,0($t0)
	jal	time2string
	nop
	# print a newline
	li	$a0,10
	li	$v0,11
	syscall
	nop
	# go back and do it all again
	j	main
	nop
# tick: update time pointed to by $a0
tick:	lw	$t0,0($a0)	# get time
	addiu	$t0,$t0,1	# increase
	andi	$t1,$t0,0xf	# check lowest digit
	sltiu	$t2,$t1,0xa	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x6	# adjust lowest digit
	andi	$t1,$t0,0xf0	# check next digit
	sltiu	$t2,$t1,0x60	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa0	# adjust digit
	andi	$t1,$t0,0xf00	# check minute digit
	sltiu	$t2,$t1,0xa00	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x600	# adjust digit
	andi	$t1,$t0,0xf000	# check last digit
	sltiu	$t2,$t1,0x6000	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa000	# adjust last digit
tiend:	sw	$t0,0($a0)	# save updated result
	jr	$ra		# return
	nop

  # you can write your code for subroutine "hexasc" below this line
  #
  
hexasc:
	move 	$t0, $a0	# move a0 to t0
	andi	$t0, $t0, 15	# 4 least significant bits from a0, ignore other bits.
	slti	$t1, $t0, 10	# If t0 < 10, t1 = 1 else t1=0
	bne	$t1, $zero, L1
	nop	# If t1 is not equal to 0 i.e t1 = 1, jump to L1
	addi	$v0, $t0, 55	# Ascii code for A-F is in range 41 to 46 (base16). Since 41 (base16) = 55 (base10), we need to add 55.
  	jr	$ra
  	nop
 
L1:
  	addi	$v0, $t0, 48	# Ascii code for 0-9 is in range 30 to 39 (base16). We need to add 30.
  	jr	$ra
  	nop
  	
delay:
	move 	$t0, $a0	# $t0 = ms
	addi 	$t2, $zero, 1	# Upper boundary in for loop
	
while:	
	add 	$t1, $zero, $zero	# i = 0
	beqz	$t0, doneWhile	# if $t0 == 0, done
	nop
	subi	$t0, $t0, 1	# Decrement ms
	
 for:
 	beq	$t1, $t2, doneFor	# if i == 4711 for loop done, jump to doneFor
 	nop
 	addi	$t1, $t1, 1	# Increment i
 	j	for	# Jump to for
 	nop
 doneFor:
 	j	while	# Jump to while
 	nop	
doneWhile:
	jr	$ra
	nop
time2string:
	PUSH	$ra
	PUSH	$s0
	PUSH	$s1
	PUSH	$s2
	PUSH	$s3
	PUSH	$s4
	PUSH	$s5
	PUSH	$s6
	PUSH	$a0

	
  	sll	$a1, $a1, 16 # ignore bits except least significant 16
  	srl	$a1, $a1, 16
  	
  	srl	$a0, $a1, 12 # get rid of all bits except the ones we want to have in first digit of time, if we want to print 16:53, this gives us the 1
  	jal	hexasc
  	nop
  	move	$s0, $v0
  	
  	sll	$a0, $a1, 20  # get rid of all bits except the ones we want to have in second digit of time, if we want to print 16:53, this gives us the 6
  	srl	$a0, $a0, 28
  	jal	hexasc
  	nop
  	move	$s1, $v0
  	
  	sll	$a0, $a1, 24  # get rid of all bits except the ones we want to have in fourth digit of time, if we want to print 16:53, this gives us the 5
  	srl	$a0, $a0, 28
  	jal	hexasc
  	nop
  	move	$s2, $v0
  	
  	sll	$a0, $a1, 28 # get rid of all bits except the ones we want to have in fifth digit of time , if we want to print 16:53, this gives us the 3
  	srl	$a0, $a0, 28
  	jal	hexasc
  	nop
  	move	$s3,$v0
  	addi	$s4, $zero, 0x3A # Add ASCII ':' to $s4
  	
  	beq	$s2, $zero, firstDig
  	nop
  	j	notEqual
  	nop
firstDig:	
	beq	$s3, $zero, printX  
	nop
	j	notEqual
	nop
  	#addi	$s5, $zero, 0x00 # Add ASCII NULL to $s5
printX:
	addi	$s5, $zero, 0x58
	addi	$s6, $zero, 0x00 # Add ASCII NULL to $s6
	j	done
	nop
	
notEqual:
  	addi	$s5, $zero, 0x00 # Add ASCII NULL to $s5
  	nop
  	
done:
  	POP	$a0 # pop $a0 to restore $a0 to use in main  
 
  	sb	$s0, 0($a0) # Store $s0 in first byte 
  	sb	$s1, 1($a0)
  	sb	$s4, 2($a0)
  	sb	$s2, 3($a0)
  	sb	$s3, 4($a0)
  	sb	$s5, 5($a0)
  	sb	$s6, 6($a0)
  	
  	sll	$a0, $a0, 12
  	srl	$a0, $a0, 12
  	
  	POP	$s6
  	POP	$s5
  	POP	$s4
  	POP	$s3
  	POP	$s2
  	POP	$s1
  	POP	$s0
  	POP	$ra
  	
  	jr	$ra
  	nop
