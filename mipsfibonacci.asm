	.data
tab: .asciiz "   "
pt: .asciiz "."
enter: .asciiz "\n"
grtable: .asciiz "Golden Ratio Table \nA   B   B/A\n"
name: .asciiz "Name: Jason Jackrel"
comma: .asciiz ", "
fibseq: .asciiz "15 terms of Fibonacci sequence \n"
	.text
	.globl main
	
main:
li $v0, 4
la $a0, name
syscall
li $v0, 4
la $a0, enter
syscall
li $v0, 4
la $a0, fibseq
syscall
addi $s2, $zero, 0
addi $s1, $zero, 1
fibloop:
li $v0, 1
move $a0, $s0
syscall
li $v0, 4
la $a0, comma
syscall
bge $s0, 377, fibloopend
addi $s2, $s1, 0
addi $s1, $s0, 0
add $s0, $s1, $s2
j fibloop
fibloopend:
li $v0, 4
la $a0, enter
syscall
li $v0, 4
la $a0, grtable
syscall

addi $t0, $zero ,1
addi $t1, $zero ,2
loop:
add $t2, $t1, $t0
li $v0, 1
move $a0, $t1
syscall
li $v0, 4
la $a0, tab
syscall
li $v0, 1
move $a0, $t2
syscall
li $v0, 4
la $a0, tab
syscall

mul $t4, $t2, 100000
div $t5, $t4, $t1 
div $t3, $t5, 100000
sub $t5, $t5, 100000

li $v0, 1
move $a0, $t3
syscall
li $v0, 4
la $a0, pt
syscall
li $v0, 1
move $a0, $t5
syscall

addi $t0, $t1, 0
addi $t1, $t2, 0
add $t2, $t1, $t0
li $v0, 4
la $a0, enter
syscall
bge $t2, 610, loopend
j loop
loopend:

li $v0, 10
syscall
