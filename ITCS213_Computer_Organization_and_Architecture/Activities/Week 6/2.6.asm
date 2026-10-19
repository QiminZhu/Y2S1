# Title:       Question 2.7
# Author:      Qimin Zhu 6888143
# Date:        12/09/2026
# Description: 
# Input:       
# Output:      

################## Data segment ##################

.data

promptA:  .asciiz "Enter an integer: "
newline:  .asciiz "\n"


################## Code segment ##################

.text

.globl main

main:

    # Print prompt for the integer
    li   $v0, 4
    la   $a0, promptA
    syscall

    # Read a signed integer
    li   $v0, 5
    syscall
    move $s0, $v0
    
    # Load mask
    li   $s1,  0x55555555 # Mask 1 for odd
    li   $s2,  0xaaaaaaaa # Mask 2 for even

    # Extra odd and shift to even
    and  $s3, $s0, $s1  
    sll  $s3, $s3, 1
    
    # Extra even and shift to odd
    and  $s4, $s0, $s2
    srl  $s4, $s4, 1 
    
    # Combine them by or
    or   $s5, $s3, $s4
    
    # Print the result
    li   $v0, 1
    move $a0, $s5
    syscall
   