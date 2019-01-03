.data

array: .word 5, 81, 12, -10, -31, 43, 10, 100, 241, 415, 79, 88, 56, 22, 98, 120, 90, 4, 349, 8, 45, 37, 43, 67, 3, 18, 97, 71, 10000
orgarray: .word 5, 81, 12, -10, -31, 43, 10, 100, 241, 415, 79, 88, 56, 22, 98, 120, 90, 4, 349, 8, 45, 37, 43, 67, 3, 18, 97, 71, 10000
enter: .asciiz "\n"
comma: .asciiz ", "
originalarray: .asciiz "The original array is: \n"
sortedarray1: .asciiz "The sorted array by insertion sort is: \n"
sortedarray2: .asciiz "The sorted array by selection sort is: \n"
qtpt: .asciiz "\n The quarter point is:"
name: .asciiz "My name is Jason\n"
.text
.globl main2

main2:
la $a1, array
la $a2, orgarray
jal selectsort

jal copy

jal insertsort

li $v0, 10
syscall


selectsort: 
li $v0, 4
la $a0, name
syscall#name print
la $a0, originalarray
syscall#more piritnt
addi $t0, $a1, 0
printloop:#print numbers

li $v0, 1
lw $a0, ($t0)
beq $a0, 10000, printend
syscall
li $v0, 4
la $a0, comma
syscall
addi $s7, $s7, 1
addi $t0, $t0, 4
j printloop
printend:

li $v0, 4
la $a0, enter
syscall

outloop:#slection sort
div $s6, $s7, 4
bne $s2, $s6, skipbne#print at quarter
li $v0, 4
la $a0, qtpt
syscall
addi $t0, $a1, 0
printloop3:#print

li $v0, 1
lw $a0, ($t0)
beq $a0, 10000, printend3
syscall
li $v0, 4
la $a0, comma
syscall
addi $t0, $t0, 4
j printloop3
printend3:
li $v0, 4
la $a0, enter
syscall
skipbne:
addi $t3, $zero, 99999
li $s0, 0
add $s0, $s0, $s2
addi $t0, $a1, 0
mul $s3, $s2, 4
add $t0, $t0, $s3

	inloop:#find smallest number
		lw $s1, ($t0)
		beq $s1, 10000, loopend
		bge $s1, $t3, skip
		addi $t3, $s1, 0
		addi $t4, $s0, 0
		skip:
		addi $s0, $s0, 1
		bge $s0, $s7, inend
		subi $s0, $s0, 1
		addi $s0, $s0, 1
		addi $t0, $t0 ,4
		li $v0, 1
addi $a0, $s1, 0
#syscall
li $v0, 4
la $a0, comma
#syscall	
		j inloop
		
	inend:
addi $t0, $a1, 0#swap numbers
mul $t5, $t4, 4
add $t0, $t0, $t5
lw $t7, ($t0)
addi $t0, $a1, 0
mul $t5, $s2, 4
add $t0, $t0, $t5
lw $t6, ($t0)
addi $t0, $a1, 0
mul $t5, $t4, 4
add $t0, $t0, $t5
sw $t6, ($t0)
addi $t0, $a1, 0
mul $t5, $s2, 4
add $t0, $t0, $t5
sw $t7, ($t0)

li $v0, 1
addi $a0, $t3, 0
#syscall
li $v0, 4
la $a0, comma
#syscall

bge $s2, $s7, loopend 
addi $s2, $s2, 1
j outloop
loopend:

print:#print final
li $v0, 4
la $a0, sortedarray2
syscall
addi $t0, $a1, 0
printloop2:

li $v0, 1
lw $a0, ($t0)
beq $a0, 10000, printend2
syscall
li $v0, 4
la $a0, comma
syscall
addi $t0, $t0, 4
j printloop2
printend2:
#copy from ($a2) to array
li $t5, 0
li $t6, 0
addi $t0, $a1, 0
la $t6, ($a2)
jr $ra

copy:
bge $t5, $s7, copyend
lw $t4,($t6)
sw $t4, ($t0)
addi $t0, $t0, 4
addi $t6, $t6, 4
addi $t5, $t5, 1
j copy
copyend:
#reset
li $t0, 0
li $t1, 0
li $t2, 0
li $t3, 0
li $t4, 0
li $t5, 0
li $t6, 0
li $t7, 0
li $t8, 0
li $t9, 0
li $s0, 0
li $s1, 0
li $s2, 0
li $s3, 0
li $s4, 0
li $s5, 0
li $s6, 0
li $s7, 0


li $v0, 4
la $a0, enter
syscall
syscall
syscall

jr $ra

insertsort:

#more prints
li $v0, 4
la $a0, originalarray
syscall

add $t0, $zero, 0 #set $t0, increment counter = 4,for error 
#la $t2, length #t2 contains the address for length
addi $t3, $a1, 0 #t3 conatins the address for the array for accessing the data
#lw $t1, ($t2) #t1 gets the length of the array for reference against t0
li $v0, 1#set v0 for printing integers
presortprint:#prints the aray before bubble sort
#bge $t0, $t1, presortend #if loop has looped refernce amount of times, end
li $v0, 1#set v0 for printing integers
lw $a0, ($t3) 
beq $a0, 10000, presortend
syscall

li $v0, 4
la $a0, comma
syscall
add $t3, $t3, 4
add $t0,$t0,1
j presortprint
presortend:
add $t1, $t0, 0
div $a3, $t1, 4
addi $t3, $a1, 0 #t3 conatins the address for the array for accessing the data

#s0 is the counter of swaps for sort
#s1 is the counter for num times inloop ran against the ref.
#s2 is the number of a[i]
#s3 is the number of a[i+1]
#s4 is the temp var for swapping
#s7 is the org num for checking end
add $s5, $zero, 0
addi $t3, $a1, 0
lw $s7, ($t3)
add $t8, $zero, 0
mainloop:
mul $s6, $t1, 4
add $t3, $t3, $s6
add $s0, $zero, 0
add $s1, $t1 ,0
addi $t3, $a1, 0
mul $t9, $t8, 4
subi $t9, $t9, 4
add $t3, $t3, $t9
	inloop2:
	lw $s2, 4($t3)
	lw $s3, ($t3)
	
	beqz $s3, skip2
	bge $s2, $s3, skip2
	j lwskip
	#bge $s2, 0, lwskip
	#bge $s3, 0, lwskip
	#sw $s2, ($t3)
	#lw $s2, ($t3)
	#sw $s2, ($t3)
	#sw $s3, 4($t3)
	#lw $s3, 4($t3)
	#sw $s3, 4($t3)
	#add $s0, $s0, 1
	j skip
	lwskip:
	sw $s3, 4($t3)
	sw $s2, ($t3)
	add $s0, $s0, 1
	skip2:
	
	subi $t3, $t3, 4
	subi $s1, $s1, 1
	beqz $s1, inloopend
	
	j inloop2	
	inloopend:
#debug---------

bne $t8, $a3, presortend2
li $v0, 4
la $a0, qtpt
syscall
add $t0, $zero, 0 #set $t0, increment counter = 4,for error 
#la $t2, length #t2 contains the address for length
addi $t3, $a1, 0 #t3 conatins the address for the array for accessing the data
#lw $t1, ($t2) #t1 gets the length of the array for reference against t0
li $v0, 1#set v0 for printing integers
presortprint2:#prints the aray before bubble sort
#bge $t0, $t1, presortend #if loop has looped refernce amount of times, end
li $v0, 1#set v0 for printing integers

lw $a0, ($t3) 
beq $a0, 10000, presortend2
syscall

li $v0, 4
la $a0, comma
syscall
add $t3, $t3, 4
add $t0,$t0,1
j presortprint2

presortend2:
#enddebug-------
bge $t8, $t1, loopend2
add $t8, $t8, 1
add $s5, $s5, 1
j mainloop
loopend2:

li $v0, 4
la $a0, enter
syscall
li $v0, 4
la $a0, sortedarray1
syscall
add $t0, $zero, 0 #set $t0, increment counter = 4,for error 
#la $t2, length #t2 contains the address for length
addi $t3, $a1, 0 #t3 conatins the address for the array for accessing the data
#lw $t1, ($t2) #t1 gets the length of the array for reference against t0
li $v0, 1#set v0 for printing integers
presortprint3:#prints the aray before bubble sort
#bge $t0, $t1, presortend #if loop has looped refernce amount of times, end

li $v0, 1#set v0 for printing integers
lw $a0, ($t3) 
beq $a0, 10000, presortend3
syscall

li $v0, 4
la $a0, comma
syscall
add $t3, $t3, 4
add $t0,$t0,1
j presortprint3
presortend3:

jr $ra
