# Title:       Euql



# Author:      Qimin Zhu 6888143



# Date:        02/09/2026



# Description: It checks if a and b equal



# Input:       2



# Output:      2




################## Data segment ##################



.data



prompt_a:  .asciiz "Enter an integer a: "         # Your strings / variables here

prompt_b:  .asciiz "Enter an integer b: "         # Your strings / variables here

is_equal:  .asciiz "They are equal.\n"
not_equal:  .asciiz "They are not euqal.\n"



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

    beq $t0, $t1, result
    
    li   $v0, 4
    la   $a0, not_equal
    syscall
    j   exit_program
    
result:

    li   $v0, 4
    la   $a0, is_equal
    syscall
    
exit_program:
    
    li   $v0, 10
    syscall

