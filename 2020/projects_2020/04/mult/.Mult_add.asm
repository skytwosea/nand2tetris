// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)


// R0 * R1 --> R2

// Declarations

@R2     // product address to A
M=0     // initialize product to 0
(LOOP)  // LOOP address label. Target for iterative loop

// test condition first

@R1     // multiplicand to A
D=M     // multiplicand to D
@END    // END address to A
D;JLE   // jump to END iff D <= 0

// body of iteration

@R0     // multiplier to A
D=M     // multiplier to D
@R2     // result to A
M=D+M   // result ([M]R2) = multiplier (D reg) + result (M[R2])
@R1     // multiplicand to A
M=M-1     // decrement multiplicand
@LOOP   // LOOP address to A
0;JMP   // uncond. jump to loop

// program termination loop

(END)   // END address label. Target for termination loop
@END
0;JMP   // infinite loop
