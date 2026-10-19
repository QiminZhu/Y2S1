# Title:       Question 2.1

# Author:      Qimin Zhu 6888143

# Date:        12/09/2026

# Description: Calculation

# Input:       [The test input you used, e.g. 20]

# Output:      [The exact output MARS printed, e.g.]

#   Enter an integer: 20

#   You entered: 20

################## Data segment ##################

.data

promptA:  .asciiz "Enter an integerA: "         # Your strings / variables here

promptB:  .asciiz "Enter an integerB: "         # Your strings / variables here

################## Code segment ##################

.text

.globl main                  # mark the “main” function as globally visible.



main:                        # main function entry

    li   $v0, 4              # Service 4 = print string
    la   $a0, promptA         # Load the address of the prompt1 text
    syscall                  # Print the prompt
    
    li   $v0, 5              # Service 5 = read integer
    syscall                  # Read the integer into $v0
    move $t0, $v0            # Copy the input value into $t0
    
    li   $v0,  4		# Load prompt2
    la   $a0, promptB
    syscall
    
    li   $v0, 5
    syscall
    move   $t1, $v0
    
    add  $t2, $t1, $t1
    sub  $t2, $t2, 5
    add  $t3, $t0, $t2

    li   $v0, 1
    move $a0, $t3
    syscall
