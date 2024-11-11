// testy hesty

// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)


// R0 * R1 --> R2

// Declarations
@R0     // multiplier; set by test file
D=M
@R3
M=D     // multiplier copy in R3
@R1     // multiplicand; set by test file
D=M
@R4
M=D     // multiplicand copy in R4
@R2     // product, init. to 0
M=0
@16     // bit-width, init. to 16 (1 word)
D=A
@R5
M=D
@16384  // sign-bit test value, init. to 0100 0000 0000 0000 = 16384
D=A
@R6
M=D
@1      // bit-order value, init. to 0000 0000 0000 0001
D=A
@R7
M=D
@16     // iteration counter, init. to 16
D=A
@R8
M=D



(LENGTH) // measure length of multiplier, using copy in R3
@R3     // multiplier copy
D=M
@R6     // sign bit
D=D&M   // test whether MSB of multiplier copy is asserted
@ITERATOR
D;JGT   // if MSB of multiplier copy is asserted, go to next loop
@R5
M=M-1   // decrement width
@R3
D=M
M=D+M   // left-shift multiplier-copy
@LENGTH
0;JMP   // loop to top of LENGTH block

(ITERATOR) // measure length of multiplicand, using copy in R4
@R4     // multiplicand copy
D=M
@R6     // sign bit
D=D&M   // test whether MSB of multiplicand copy is asserted
@MULT
D;JGT   // if MSB of multiplicand copy is asserted, go to next loop
@R8
M=M-1   // decrement iterator counter
@R4
D=M
M=D+M   // left-shift multiplicand-copy
@ITERATOR
0;JMP   // loop to top of ITERATOR block
// test if combined widths of multiplicand and multiplier will overflow
@R5     // width to A
D=M
@R8
D=D+M   // sum of width and iterator
@16
D=D-A   //
@ERROR
D;JGE   // if (sum of width + iterator) - 16 is >= 0, then product will overflow. Return -1


(MULT)  // multiplication loop
@R8     // iterator counter
D=M
@END
D;JLE   // jump to END if iterator counter <= 0
@R1
D=M
@R7
D=D&M   // test if nth bit is asserted in multiplicand
@MULT_HIGH
D;JGT
// if-zero sub-block
@R0
D=M
M=D+M   // left-shift multiplier
@R7
D=M
M=D+M   // left-shift bit-order
@R8
M=M-1   // decrement iterator counter
@MULT
0;JMP
// if-pos sub-block
(MULT_HIGH)
@R0
D=M
@R2
M=D+M   // add multiplier to product
@R0
D=M
M=D+M   // left-shift multiplier
@R7
D=M
M=D+M   // left-shift bit order
@R8
M=M-1   // decrement iterator counter
@MULT
0;JMP

// program error block
(ERROR)
@-1     // set product to -1
D=A
@R2
M=D

// program termination loop
(END)   // END address label. Target for termination loop
@END
0;JMP   // infinite loop
