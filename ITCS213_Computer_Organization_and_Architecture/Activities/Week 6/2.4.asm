# Title:       Question 2.5
# Author:      Qimin Zhu 6888143
# Date:        12/09/2026
# Description: 
# Input:       
# Output:      

################## Data segment ##################

.data

promptA:  .asciiz "Enter a integer: "
promptB:  .asciiz "Enter a num(0-31): "
newline:  .asciiz "\n"

################## Code segment ##################

.text

.globl main

main:

    # Print the promptA
    li   $v0, 4
    la   $a0, promptA
    syscall
    
    # Read a integer from input
    li   $v0, 5
    syscall
    move $s0, $v0

    # Print the promptB
    li   $v0, 4
    la   $a0, promptB
    syscall
    
    # Read a num from input
    li   $v0, 5
    syscall
    move $s1, $v0

    # shift it
    srlv $s2, $s0, $s1
    
    # addi 1
    andi $s2, $s2, 1
    
    # Print the result
    li   $v0, 1
    move $a0, $s2
    syscall