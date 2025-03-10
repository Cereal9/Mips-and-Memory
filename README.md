# MIPS and Memory Program

## Description
This MIPS assembly language program manipulates an array stored in memory by implementing several functions to:
- Find the minimum and maximum values
- Print values at specific addresses
- Swap values at given addresses
- Print the entire array

The program is tested and debugged using an online MIPS simulator like JsSpim.

## Functions Implemented
### 1. `findMinAddress(int &array, int size)`
Finds the smallest number in the array and returns its memory address.

### 2. `findMaxAddress(int &array, int size)`
Finds the largest number in the array and returns its memory address.

### 3. `printValueAtAddress(int address)`
Prints the value stored at a specified memory address.

### 4. `swapValues(int &address1, int address2)`
Swaps the values stored at two different memory addresses.

### 5. `printArray(int &array, int size)`
Prints all elements in the array.

## Program Workflow
1. **Print Initial Array:** Displays the contents of the array before any operations.
2. **Find and Print Minimum Value:** Uses `findMinAddress()` and `printValueAtAddress()` to display the minimum value and its address.
3. **Find and Print Maximum Value:** Uses `findMaxAddress()` and `printValueAtAddress()` to display the maximum value and its address.
4. **Swap Minimum and Maximum Values:** Uses `swapValues()` to interchange the minimum and maximum values in the array.
5. **Print Modified Array:** Displays the array after swapping the minimum and maximum values.

## Known Issue
- **Incorrect Maximum Value Selection:** The program always returns the first value as the maximum, even if the max value is elsewhere in the array. This is likely due to a logical error in the `findMaxAddress()` function.

## Instructions for Testing
1. Copy the provided MIPS assembly code into an editor.
2. Use an online MIPS simulator like JsSpim.
3. Run the program and check for the expected outputs.
4. Verify that values swap correctly and that addresses match expected results.
5. Debug and modify as necessary to ensure correctness.

## Notes
- Ensure the stack and registers are handled correctly to avoid unexpected behavior.
- Debugging tools in JsSpim can help track memory and register changes during execution.

---

