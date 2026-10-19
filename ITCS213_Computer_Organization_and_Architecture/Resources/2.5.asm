# Title:       Question 2.6
# Author:      Qimin Zhu 6888143
# Date:        12/09/2026
# Description: Multiply a signed integer by 24.5 using shifts
# Input:       A signed integer
# Output:      The integer result of 24.5 × input

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

    # Calculate x × 16
    sll  $s1, $s0, 4

    # Calculate x × 8
    sll  $s2, $s0, 3

    # Calculate x / 2
    sra  $s3, $s0, 1

    # Calculate 16x + 8x
    add  $s4, $s1, $s2

    # Calculate 24x + x/2
    add  $s5, $s4, $s3

    # Print the result
    li   $v0, 1
    move $a0, $s5
    syscall