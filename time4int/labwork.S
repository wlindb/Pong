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
  	.global		delay	
  	.global		time2string
  	.global		enable_interrupt
  	.data
	.text

  # you can write your code for subroutine "hexasc" below this line
  #
  hexasc:
	move	$t0, $a0	# copy from a0 to t0
	andi	$t0, $t0, 15	# check that t0 is less than 16
	
	slti	$t1, $t0, 10	# check if t0 < 10 t1 = 1 if true else t1 = 0
	
	bne	$t1, $0, L1	# branch if t0 != 0, otw continue
	nop
	
	addi	$v0, $t0, 55	# t0 => 10 && t0 =< 15 add code prefix
	jr	$ra
	nop
L1:
	addi	$v0, $t0, 48	# t0 < 10 && t0 => 0 add code prefix
	jr	$ra
	nop
	
delay:
	#jr	$ra
	#nop	
	move	$t0, $a0		# to = ms
	add	$t2, $zero, 4450	# loop constant
	
while:
	add	$t1, $zero, $zero	# i = 0
	beq	$t0, $zero, doneWhile	# while loop finished
	nop
	addi	$t3, $zero, 1
	sub	$t0, $t0, $t3

for:
	beq	$t1, $t2, doneFor # i == constant, for loop finished
	nop
	addi	$t1, $t1, 1	  # increament i
	j	for
	nop
doneFor:
	j	while
	nop
doneWhile:
	jr	$ra
	nop
	
	
time2string:
	PUSH 	$ra		# Save return adress
	PUSH	$s0		# Save s0 - s5 
	PUSH	$s1
	PUSH	$s2
	PUSH	$s3
	PUSH	$s4
	PUSH	$s5
	PUSH	$a0		# Save original a0 content
	
	addi	$s4, $0, 0x3A	# Colon variable
	addi	$s5, $0, 0x00	# Null variable
	
	sll 	$a1, $a1, 16	# Save 16 lsd
	srl	$a1, $a1, 16	# Put them on the right spot
	
	srl	$a0, $a1, 12	# adjust bits
	jal	hexasc		# retrieve ASCII code for first digit
	nop
	move	$s0, $v0	# return to s0
	
	sll	$a0, $a1, 20	# adjust bits
	srl	$a0, $a0, 28
	jal 	hexasc		# retrieve ASCII code for second digit
	nop
	move	$s1, $v0	# return to s1
	
	sll	$a0, $a1, 24	# adjust bits
	srl	$a0, $a0, 28
	jal 	hexasc		# retrieve ASCII code for third digit
	nop
	move	$s2, $v0	# return to $s2
	
	sll	$a0, $a1, 28	# adjust bits
	srl	$a0, $a0, 28
	jal 	hexasc		# retrieve ASCII code for fourth digit
	nop
	move	$s3, $v0	# return to $s3
	
	POP	$a0
	
	sb	$s0, 0($a0)	# put s0 - s5 values into the adress whom a0 is pointing at
	sb	$s1, 1($a0)
	sb	$s4, 2($a0)
	sb	$s2, 3($a0)
	sb	$s3, 4($a0)
	sb	$s5, 5($a0)
	
	POP	$s5	# restore original values in s registers and ra
	POP	$s4
	POP	$s3
	POP	$s2
	POP	$s1
	POP	$s0
	POP	$ra
	
	jr	$ra	# jump back
	nop
enable_interrupt:
	ei
	j	$ra
	nop

