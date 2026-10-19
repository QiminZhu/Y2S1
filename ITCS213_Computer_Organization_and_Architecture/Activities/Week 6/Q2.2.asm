# Title:       Question 2.2
# Author:      Qimin Zhu 6888143
# Date:        12/09/2026
# Description: 
# Input:       
# Output:      

################## Data segment ##################

.data

promptA:  .asciiz "Enter an integer A: "
promptB:  .asciiz "Enter an integer B: "
newline:  .asciiz "\n"

################## Code segment ##################

.text

.globl main

main:

    # Read integer A
    li   $s1, 0x12345678

    # Read integer B
    li   $s2, 0xffff9a00

    # Calculate and
    add  $s3, $s1, $s2

    # Print result
    li   $v0, 34
    move $a0, $s3
    syscall
    li   $v0, 4
    la   $a0, newline
    syscall
    
    # Calculate or
    or   $s4, $s1, $s2
    
    # Print result
    li   $v0, 34
    move $a0, $s4
    syscall
    li   $v0, 4
    la   $a0, newline
    syscall
    
    # Calculate xor
    xor   $s5, $s1, $s2
    
    # Print result
    li   $v0, 34
    move $a0, $s5
    syscall
    li   $v0, 4
    la   $a0, newline
    syscall
    
    # Calculate nor
    nor   $s6, $s1, $s2
    
    # Print result
    li   $v0, 34
    move $a0, $s6
    syscall