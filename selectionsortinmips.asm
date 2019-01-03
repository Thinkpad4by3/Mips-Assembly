#my problem is with the selection sort is that I keep getting one as the lowest value even though it doesn`t exist.
	
			.data
array: .word 8,6,5,7,3,2,32
enter: .asciiz "\n"
	.text
	.globl main

main: 
	la	$s0, array	# $s0 contains base address of str
	add	$s2, $0, $0	# $s2 = 0
	addi	$s3, $0, 0	# $s2 = '\n'
loop2:
	lb	$s1, ($s0)	# load character into $s0
	li $v0, 1
add $a0, $s1, $zero
syscall#display number in each segment of hte array
	beq	$s1, $s3, end	# Break if byte is newline
	addi	$s2, $s2, 1	# increment counter
	addi	$s0, $s0, 4	# increment str address
	j	loop2
end:
div $s2, $s2, 1 #useless line

li $v0, 4
la $a0, enter
syscall #display enter

li $v0, 1
add $a0, $s2, $zero
syscall # display length of array
li $v0, 4
la $a0, enter
syscall#enter again
#ints
#s2 = length of array
#t0 = loop times of outside array
#t1 = current least int
	addi $t2, $t2, 999
loop:
	beq $t0, $s2, loopend #if looped length of array times, go to end
	lb $s1, ($s0)# load bytes from array into s1
	lb $s5, ($s0)# same for s5
	mul $s4, $s2, 1 #transfer s2 into s4
	add $s1, $s1, $s4 #increment s1 by s4

	insideloop:
	bge $s1, $t2, skip # if array num is greater than previous least num, skip
	addi $t2, $s1, 0 # set num as least num
	skip: 
	subi $s1, $s1, 1 #increment down address
	beq $s1, $s5, insideloopend #end loop
	j insideloop  		
	insideloopend:
	li $v0, 1
add $a0, $t2, $zero
syscall#display lowest num
li $v0, 4
la $a0, enter
syscall#enter
	addi $t0, $t0, 1#increment counter
	j loop
loopend:

li $v0, 10
syscall#end program

