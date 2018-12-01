  # hexmain.asm
  # Written 2015-09-04 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

	.text
main:
	li	$a0,17		# change this to test different values

	jal	hexasc		# call hexasc
	nop			# delay slot filler (just in case)	

	move	$a0,$v0		# copy return value to argument register

	li	$v0,11		# syscall with v0 = 11 will print out
	syscall			# one byte from a0 to the Run I/O window
	
stop:	j	stop		# stop after one run
	nop			# delay slot filler (just in case)


hexasc:
	move 	$t0, $a0	# move a0 to t0
	andi	$t0, $t0, 15	# 4 least significant bits from a0, ignore other bits.
	slti	$t1, $t0, 10	# If t0 < 10, t1 = 1 else t1=0
	bne	$t1, $zero, L1	# If t1 is not equal to 0 i.e t1 = 1, jump to L1
	nop
	addi	$v0, $t0, 0x55	# Ascii code for A-F is in range 41 to 46 (base16). Since 41 (base16) = 55 (base10), we need to add 55.
  	jr	$ra
  	nop
 
  L1:
  	addi	$v0, $t0, 0x30	# Ascii code for 0-9 is in range 30 to 39 (base16). We need to add 30.
  	jr	$ra
  	nop
  		 
	
