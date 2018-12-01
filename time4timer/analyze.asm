  # analyze.asm
  # This file written 2015 by F Lundevall
  # Copyright abandoned - this file is in the public domain.

	.text
main:
	li	$s0,0x30		# load immediate  $s0 with 0x30 = 48 base10 
loop:
	move	$a0,$s0		# copy from s0 to a0 
	
	li	$v0,11		# syscall with v0 = 11 will print out, 11 means it will print out an character.
	syscall			# one byte from a0 to the Run I/O window
				# In first run of the loop $a0 = 0x30 which is the ASCII character 0.

	addi	$s0,$s0,3		# what happens if the constant is changed?
				# The constant increments $s0 by 1, if the constant is changed $s0 will increment by another value.
				# Since bne is dependent on $t0 and $s0, changing the amount of increment may affect the program.
	
	li	$t0,0x5d		# load immediate  $t0 with 0x5b = 91 base10. 0x5a is Z in ASCII
	bne	$s0,$t0,loop		# When Z has been printed out, loop is done.
	nop	

stop:	j	stop		# loop forever here
	nop			# delay slot filler (just in case)

