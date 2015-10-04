# This MIPS assembly code does specific arithematic operation to user inputted integers, and was written by Samman Bikram Thapa and Samuel Raymond of Howard University
# as part of a project in their Computer Organization class taught by Dr. Gedare Bloom in Fall 2015 session.

.data

buffer : .space 20
prompt: .asciiz "\nPlease enter an integer:\n"
sign_plus : .asciiz " + "
sign_minus : .asciiz " - "
sign_multiply : .asciiz " * "
sign_open_parenthesis : .asciiz "("
sign_close_parenthesis : .asciiz ")"
sign_equals : .asciiz " = "

.text

main:
addi $t1, $0, 0                 # int i = 0;
addi $t2, $0, 1                 # int truth = 1

LOOP:                           # do {
la $a0, prompt                  # loading the prompt to display at the console
li $v0, 4                       # cout << prompt
syscall

li $v0, 5                       # reading the integer that users providing
syscall                         # cin >> $v0

sll $t4, $t1, 2 		# $t4 = $t1 << 2
sw $v0, buffer($t4)		# buffer[$t4] = usr_input 

slt $t3, $0, $v0                # if ($0 < usr_input) { $t3 = 1 } else { $t3 = 0 }
beq $t3, $0, NOTINLIMIT        	# if ($t3 != 0) { GOTO INLIMIT }

slt $t3, $v0, 32768             # if (usr_input < 32768) { $t3 = 1} else { $t3 = 0 }            
beq $t3, $0, NOTINLIMIT		# if ($t3 != 0) { GOTO INLIMIT }

j INLIMIT

NOTINLIMIT:
addi $t2, $0, 0 		# set $t2 = 0 i.e to false

INLIMIT:
addi $t1, $t1, 1                # i++

slt $t3, $t1, 5
bne $t3, $0, LOOP             	# } while (i < j) {GOTO LOOP }

bne $t2, $0, ADDITION           # if (truth == $0 )
addi $t1, $0, 0                 # { i = 0
addi $t2, $0, 1                 #   truth = 1 }
j LOOP				# GOTO LOOP

ADDITION:

li $t0, 0			# x = 0
lw $t0, buffer($t0)		# x = buffer[0]
#
##displaying the numbers as per the output format
#
la $a0, ($t0)			
li $v0, 1
syscall
#display sign
la $a0, sign_plus
li $v0, 4
syscall

# next number in the memory
li $t1, 4			# y = 4
lw $t1, buffer($t1)		# y = buffer[4]
# display number
la $a0, ($t1)			
li $v0, 1
syscall
#display sign
la $a0, sign_minus
li $v0, 4
syscall

# display parenthesis
la $a0, sign_open_parenthesis
li $v0, 4
syscall 

# next number in the memory
li $t1, 8			# y = 8
lw $t1, buffer($t1)		# y = buffer[8]
# display number
la $a0, ($t1)			
li $v0, 1
syscall
#display sign
la $a0, sign_minus
li $v0, 4
syscall

# next number in the memory
li $t1, 12			# y = 12
lw $t1, buffer($t1)		# y = buffer[12]
# display number
la $a0, ($t1)			
li $v0, 1
syscall
#display sign
la $a0, sign_multiply
li $v0, 4
syscall

# next number in the memory
li $t1, 16			# y = 16
lw $t1, buffer($t1)		# y = buffer[16]
# display number
la $a0, ($t1)			
li $v0, 1
syscall

# display parenthesis
la $a0, sign_close_parenthesis
li $v0, 4
syscall

#display equals to
la $a0, sign_equals
li $v0 , 4
syscall
#
##displaying number finished
#

#
# Calculation
#
li $t0, 12
lw $t0, buffer($t0)		# $t0 = D
mult $t0, $t1			# D * E
mflo $t0			# x = D * E
# next number
li $t1, 8
lw $t1, buffer($t1)		# $t1 = C
sub $t0, $t1, $t0		# x = C - D * E
# next number
li $t1, 4
lw $t1, buffer($t1)		# $t1 = B
sub $t0, $t1, $t0		# x = B - (C - D * E)
# next number
li $t1, 0
lw $t1, buffer($t1)		# $t1 = A
add $t0, $t1, $t0		# x = A + B - (C - D * E)
#
# Calculation finished
#

# Display answer
la $a0, ($t0)
li $v0, 1
syscall

# Exit
li $v0, 10                      #load the syscall code for exiting
syscall                         #perform the system call


