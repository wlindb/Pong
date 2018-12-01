  # labwork.S
  # Written 2015-2017 by F Lundevall
  # Skeleton file for IS1200/IS1500 lab 1.
  # The macros PUSH and POP are in the public domain.
  # Please add your own code at the end of the file.

  #
  # Please keep the two macros PUSH and POP unchanged
  #
.macro	PUSH reg
	addi	$sp,$sp,-4
	sw	\reg,0($sp)
.endm

.macro	POP reg
	lw	\reg,0($sp)
	addi	$sp,$sp,4
.endm
  #
  # Please add your own code below this line
  #


	.data
	.global	delay
	.global	time2string
	.text

hexasc:
	move 	$t0, $a0	# move a0 to t0
	andi	$t0, $t0, 15	# 4 least significant bits from a0, ignore other bits.
	slti	$t1, $t0, 10	# If t0 < 10, t1 = 1 else t1=0
	bne	$t1, $zero, L1
	nop		# If t1 is not equal to 0 i.e t1 = 1, jump to L1
	addi	$v0, $t0, 55	# Ascii code for A-F is in range 41 to 46 (base16). Since 41 (base16) = 55 (base10), we need to add 55.
  	jr	$ra
  	nop
 
L1:
  	addi	$v0, $t0, 48	# Ascii code for 0-9 is in range 30 to 39 (base16). We need to add 30.
  	jr	$ra
  	nop
  	
delay:
	move 	$t0, $a0	# $t0 = ms
	add 	$t1, $zero, $zero	# i = 0
	addi 	$t2, $zero, 2000	# Upper boundary in for loop
	
while:	
	beqz	$t0, doneWhile	# if $t0 == 0, done
	nop
	addi	$t3, $zero, 1
	sub	$t0, $t0, $t3	# Decrement ms
	
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
	PUSH	$a0

	
  	#move	$s0, $a0
  	sll	$a1, $a1, 16 # ignore bits except least significant 16 
  	srl	$a1, $a1, 16
  	
  	srl	$a0, $a1, 12 # get rid of all bits except the ones we want to have in first digit of time
  	jal	hexasc
  	nop
  	move	$s0, $v0
  	
  	sll	$a0, $a1, 20  # get rid of all bits except the ones we want to have in second digit of time
  	srl	$a0, $a0, 28
  	jal	hexasc
  	nop
  	move	$s1, $v0
  	
  	sll	$a0, $a1, 24  # get rid of all bits except the ones we want to have in fourth digit of time
  	srl	$a0, $a0, 28
  	jal	hexasc
  	nop
  	move	$s2, $v0
  	
  	sll	$a0, $a1, 28 # get rid of all bits except the ones we want to have in fifth digit of time
  	srl	$a0, $a0, 28
  	jal	hexasc
  	nop
  	move	$s3,$v0
  	addi	$s4, $zero, 0x3A # Add ASCII ':' to $s4
  	addi	$s5, $zero, 0x00 # Add ASCII NULL to $s5
  	POP	$a0 # pop $a0 to restore $a0 to use in main  
 
  	sb	$s0, 0($a0) # Store $s0 in first byte of 
  	sb	$s1, 1($a0)
  	sb	$s4, 2($a0)
  	sb	$s2, 3($a0)
  	sb	$s3, 4($a0)
  	sb	$s5, 5($a0)
  	
  	sll	$a0, $a0, 12
  	srl	$a0, $a0, 12
  	
  	POP	$s5
  	POP	$s4
  	POP	$s4
  	POP	$s2
  	POP	$s1
  	POP	$s0
  	POP	$ra
  	jr	$ra
  	nop
