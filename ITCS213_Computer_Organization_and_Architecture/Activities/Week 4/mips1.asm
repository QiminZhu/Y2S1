# Title:       s = (a + b) − (c + 101)

# Author:      Qimin Zhu 6888143

# Date:        02/09/2026

# Description: calculation

# Input:       a, b, c

# Output:      s


################## Data segment ##################

.data

    prompt_a:  .asciiz "Enter the value of a: "         # Your strings / variables here
    prompt_b:  .asciiz "Enter the value of b: "
    prompt_c:  .asciiz "Enter the value of c: "
    result:  .asciiz "Result s = "

################## Code segment ##################

.text

.globl main                  # mark the “main” function as globally visible.



main:                        # main function entry

    li   $v0, 4              
    la   $a0, prompt_a         
    syscall                 

    li   $v0, 5
    syscall
    move $t0, $v0
	
    li   $v0, 4              
    la   $a0, prompt_b         
    syscall                 
    
    li   $v0, 5
    syscall
    move $t1, $v0
    
    li   $v0, 4             
    la   $a0, prompt_c         
    syscall                              
    
    li   $v0, 5
    syscall
    move $t2, $v0
    
    add $t3, $t0, $t1
    addi $t4, $t2, 101
    sub $t5, $t3, $t4
    
    li   $v0, 4
    la   $a0, result
    syscall
    
    li   $v0, 1             
    move   $a0, $t5         
    syscall                  
    
    li   $v0, 10
    syscall

