#+=======================================================================================================================================+
#|                                                                                                                                       |
#|          AUTHOR      : CESAR REAL                                                                                                     |
#|          CLASS       : CSCE 320 COMPUTER ARCHTECTURE                                                                                  |
#|          INSTRUCTOR  : DR. NWANZE                                                                                                     |
#|          DUE DATE    : MARCH 31, 2024                                                                                                 |
#|          ASSIGNMENT  : MIPS AND MEMORY PROGRAM                                                                                        |
#|                                                                                                                                       |
#|          DESCRPTION  : This MIPS assembly language program aims to manipulate an array stored in memory by implementing               |
#|          several functions to find the minimum and maximum values, print values at specific addresses, swap values at                 |
#|          given addresses, and print the entire array. The program will be tested and debugged using an online MIPS simulator          |
#|          like JsSpim.                                                                                                                 |
#|                                                                                                                                       |
#|          Functions Implemented:                                                                                                       |
#|          1. findMinAddress(int &array, int size):                                                                                     |
#|              This function iterates through the array to find the smallest number and returns the address of that number.             |
#|                                                                                                                                       |
#|          2. findMaxAddress(int &array, int size):                                                                                     |
#|              Similar to findMinAddress(), this function iterates through the array to find the largest number and returns             |
#|              its address.                                                                                                             |
#|                                                                                                                                       |
#|          3. printValueAtAddress(int address):                                                                                         |
#|              Prints the value stored at a given memory address.                                                                       |
#|                                                                                                                                       |
#|          4. swapValues(int &address1, int address2):                                                                                  |
#|              Swaps the values stored at two different memory addresses.                                                               |
#|                                                                                                                                       |
#|          5. printArray(int &array, int size):                                                                                         |
#|              Prints the entire array given its address and size.                                                                      |
#|                                                                                                                                       |
#|          Main Functionality:                                                                                                          |
#|                                                                                                                                       |
#|          1. Print Initial Array:                                                                                                      |
#|              Use the printArray() function to display the content of the array before any manipulation.                               |
#|                                                                                                                                       |
#|          2. Find and Print Minimum Value:                                                                                             |
#|              Utilize findMinAddress() to locate the smallest number in the array. Then, use printValueAtAddress() to print the        |
#|              address and value of the smallest number.                                                                                |
#|                                                                                                                                       |
#|          3. Find and Print Maximum Value:                                                                                             |
#|              Similarly, employ findMaxAddress() to find the largest number in the array. Then,use printValueAtAddress to print        |
#|              the address and value of the largest number.                                                                             |
#|                                                                                                                                       |
#|          4. Swap Minimum and Maximum Values:                                                                                          |
#|              Apply swapValues() to interchange the positions of the minimum and maximum values in the array.                          |
#|                                                                                                                                       |
#|          5. Print Modified Array:                                                                                                     |
#|              Finally, use printArray() to display the modified array after swapping the minimum and maximum values.                   |
#|                                                                                                                                       |
#|          Instructions for Testing:                                                                                                    |
#|                                                                                                                                       |
#|           1. Copy the provided MIPS assembly code into a suitable editor.                                                             |
#|           2. Modify the code as per the requirements, implementing the specified functions.                                           |
#|           3. Use an online MIPS simulator like JsSpim to debug and run the program.                                                   |
#|           4. Ensure that the output includes relevant information such as addresses, values, and the array itself.                    |
#|           5. Verify that the program executes the desired operations accurately and produces the expected results.                    |
#|                                                                                                                                       |
#+=======================================================================================================================================+



.data
welcome     :   .asciiz "Welcome to my MIPS Array Program"
newline     :   .asciiz "\n"
min         :   .asciiz "Minimum Value:"
minaddress  :   .asciiz "Minimum address (decimal):"
max         :   .asciiz "Maximum Value:"
maxaddress  :   .asciiz "Maximum address (decimal):"
size        :	.word 10
myarray     :   .word 94, 13, 3, 58, 19, 38, 28, 36, 74, 80


.text
.globl main

#+======================================================= FindMinAddress Function =======================================================+
FindMinAddress:
    addi $sp, $sp, -8           # Prepare the stack for 2 variables
    sw $ra, 4($sp)              # Save current return address on the stack
    sw $a0, 0($sp)              # Save original array address
    move $t1, $a1               # Initialize min address with the start of the array
    lw $t2, 0($a1)              # Load first element as current minimum value
    li $t0, 0                   # Initialize index to 1 (since we already considered index 0)
    for_loop_min:
        beq $t0, $a2, exit_min  # Exit loop if end of array is reached
        lw $t3, 0($a1)          # Load current element
        slt $t4, $t3, $t2       # Compare current element with current min
        beqz $t4, skip_min      # If current is not less, skip to next
        move $t2, $t3           # Update min value to current element
        move $t1, $a1           # Update min address to current address
        skip_min:
        addi $a1, $a1, 4        # Move to next element in array
        addi $t0, $t0, 1        # Increment index
        j for_loop_min
    exit_min:
        move $v0, $t1           # Move address of smallest number to return register $v0
        lw $ra, 4($sp)          # Restore return address from stack
        lw $a0, 0($sp)          # Restore original array address
        addi $sp, $sp, 8        # Restore stack pointer
        jr $ra                  # Return
#+======================================================= FindMaxAddress Function =======================================================+
#This function is very similar to the findminaddress in the sense we can reverse a line a code to find the maximum value
FindMaxAddress:
    addi $sp, $sp, -8           # Prepare the stack for 2 variables
    sw $ra, 4($sp)              # Save current return address on the stack
    sw $a0, 0($sp)              # Save original array address
    move $t1, $a1               # Initialize min address with the start of the array
    lw $t2, 0($a1)              # Load first element as current max value
    li $t0, 1                   # Initialize index to 1 (since we already considered index 0)
    for_loop_max:
        beq $t0, $a2, exit_max  # Exit loop if end of array is reached
        slt $t4, $t3, $t2       # Compare current element with current min
        bne $t4,$0, skip_max    # If current is not less, skip to next
        beqz $t4, skip_max      # If current is not less, skip to next
        move $t2, $t3           # Update min value to current element
        move $t1, $a1           # Update min address to current address
        skip_max:
        addi $a1, $a1, 4        # Move to next element in array
        addi $t0, $t0, 1        # Increment index
        j for_loop_max
    exit_max:
        move $v0, $t1           # Move address of Largest number to return register $v0
        lw $ra, 4($sp)          # Restore return address from stack
        lw $a0, 0($sp)          # Restore original array address
        addi $sp, $sp, 8        # Restore stack pointer
        jr $ra                  # Return

#+==================================================== PrintValueAtAddress Function =====================================================+
PrintValueAtAddress:
    addi $sp,$sp,-4             # Prepare the stack
    sw $ra,($sp)                # Save current return address on the stack
    lw $a0, 0($a0)
    li $v0, 1                   # System call for print integer (printing address as integer)
    syscall                     # Print the address of the minimum value
    lw $ra, ($sp)               # Restore return address from stack
    addi $sp,$sp,4              # Restore stack pointer
    jr $ra                      # Return

#+========================================================= SwapValues Function =========================================================+
SwapValues:
    addi $sp,$sp,-4             # Prepare the stack
    sw $ra,($sp)                # Save current return address on the stack
    lw  $t0, ($a0)
    lw  $t1, ($a3)
    sw $t0, 0($a3)
    sw $t1, 0($a0)
    lw $ra, ($sp)               # Restore return address from stack
    addi $sp,$sp,4              # Restore stack pointer
    jr $ra                      # Return

#+========================================================= PrintArray Function =========================================================+
PrintArray:
    addi $sp,$sp,-4             # Prepare the stack
    sw $ra,($sp)                # Save current return address on the stack
    for_loop:
        bge     $t0, $a2, exit
        # load word from addrs and goes to the next addrs
        lw      $t2, 0($a1)
        addi    $a1, $a1, 4
        # syscall to print value
        li      $v0, 1
        move    $a0, $t2
        syscall
        # optional - syscall number for printing character (space)
        li      $a0, 32
        li      $v0, 11
        syscall
        #increment counter
        addi    $t0, $t0, 1
        j      for_loop
     exit:
        lw $ra, ($sp)           # Restore return address from stack
        addi $sp,$sp,4          # Restore stack pointer
        jr $ra                  # Return

#+======================================================== Printnewline Function ========================================================+

printnewline:
    addi $sp,$sp,-4             # Prepare the stack for use of a register
    sw $ra,($sp)                # Save current return address on the stack
    #print newline
    li $v0, 4                   # syscall 4 to print string
    la $a0, newline             # pass newline string
    syscall                     # print string
    lw $ra, ($sp)               # Restore return address
    addi $sp,$sp,4              # Restore stack pointer
    jr $ra                      # Return

#+============================================================ Main Function ============================================================+
main:
    addi $sp,$sp,-4             # Prepare the stack
    sw $ra,($sp)                # Save current return address on the stack
    li $v0, 4                   # 4 is the syscall to print strings
    la $a0, welcome             # Load welcome string address into $a0
    syscall
    jal printnewline
    lw $ra, ($sp)               # Restore return address from stack
    addi $sp,$sp,4              # Restore stack pointer

    addi $sp,$sp,-4             # Prepare the stack
    sw $ra,($sp)                # Save current return address on the stack
    la      $a1, myarray
    la      $t2, size
    lw      $a2, 0($t2)
    jal PrintArray
    lw $ra, ($sp)               # Restore return address from stack
    addi $sp,$sp,4              # Restore stack pointer

    addi $sp,$sp,-4             # Prepare the stack
    sw $ra,($sp)                # Save current return address on the stack
    jal printnewline
    lw $ra, ($sp)               # Restore return address from stack
    addi $sp,$sp,4              # Restore stack pointer

    addi $sp, $sp, -4           # Prepare the stack
    sw $ra, ($sp)               # Save current return address on the stack
    la $a1, myarray             # Load address of myarray into $a0
    la $t2, size
    lw $a2, 0($t2)              # Load size into $a1
    jal FindMinAddress
    move $t3, $v0               # saving the return value into another register to use $v0 for system calls
    la $a0, minaddress          # loading the minaddress string address
    li $v0, 4
    syscall                     # printing the string
    move $a0, $t3               # loading $a0 with the address from the findminaddress function
    li $v0, 1
    syscall                     # printing the address value in decimal form
    jal printnewline
    la $a0, min                 # loading address of min string for printing
    li $v0, 4
    syscall                     # printing the value of the address
    move $a0, $t3               # moving the value from the $t3 which had the address
    li $v0, 1
    jal PrintValueAtAddress     # prints the minimum value
    lw $ra, ($sp)               # Restore return address from stack
    addi $sp,$sp,4              # Restore stack pointer

    addi $sp,$sp,-4             # Prepare the stack
    sw $ra,($sp)                # Save current return address on the stack
    jal printnewline
    lw $ra, ($sp)               # Restore return address from stack
    addi $sp,$sp,4              # Restore stack pointer


    addi $sp, $sp, -4           # Prepare the stack
    sw $ra, ($sp)               # Save current return address on the stack
    la $a1, myarray             # Load address of myarray into $a0
    la $t2, size
    lw $a2, 0($t2)              # Load size into $a1
    jal FindMaxAddress
    move $t4, $v0               # store a copy of the max address to use $v0 for system calls
    la $a0, maxaddress          # laoding the address of maxaddress
    li $v0, 4
    syscall                     # printing the string to label the maximum number in the array
    move $a0, $t4               # moving the max address into $a0 for printing
    li $v0, 1
    syscall                     #prints the decimal value of the maximum number in the array
    jal printnewline
    la $a0, max                 # loading for printing the max string
    li $v0, 4
    syscall                     #prints the max string label
    move $a0, $t4
    li $v0, 1
    jal PrintValueAtAddress
    lw $ra, ($sp)               # Restore return address from stack
    addi $sp,$sp,4              # Restore stack pointer


    addi $sp,$sp,-4             # Prepare the stack
    sw $ra,($sp)                # Save current return address on the stack
    move $a0, $t3               # smallest number address
    move $a3, $t4               # largest number address
    jal SwapValues
    lw $ra, ($sp)               # Restore return address from stack
    addi $sp,$sp,4              # Restore stack pointer


    addi $sp,$sp,-4             # Prepare the stack
    sw $ra,($sp)                # Save current return address on the stack
    jal printnewline
    lw $ra, ($sp)               # Restore return address from stack
    addi $sp,$sp,4              # Restore stack pointer


    addi $sp,$sp,-4             # Prepare the stack
    sw $ra,($sp)                # Save current return address on the stack
    la      $a1, myarray
    la      $t2, size
    lw      $a2, 0($t2)
    move $t0, $0
    jal PrintArray
    lw $ra, ($sp)               # Restore return address from stack
    addi $sp,$sp,4              # Restore stack pointer

    jr $ra                      # Return
#+=======================================================================================================================================+
