# Title:       Question 2.4
# Author:      Qimin Zhu 6888143
# Date:        12/09/2026
# Description: 
# Input:       
# Output:     

################## Data segment ##################

.data

promptA:  .asciiz "Enter an letter: "
# promptB:  .asciiz "Enter an integer B: "
newline:  .asciiz "\n"
space:    .asciiz " to "

################## Code segment ##################

.text

.globl main

main:
	
    # Read the prompt
    li  $v0, 4
    la  $a0, promptA
    syscall
    
    # Read a letter from input
    li   $v0, 12
    syscall
    move $s1, $v0

    # Load a mask letter
    li   $s0, 0x20
    
    # Calculate xor
    xor  $s2, $s1, $s0

    # Print string
    li   $v0, 4
    la   $a0, space
    syscall
    
    # Print result
    li   $v0, 11
    move $a0, $s2
    syscall
