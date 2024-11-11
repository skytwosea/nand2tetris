(MAIN)

// get keyboard value
@KBD
D=M

// assign key value to R0
@R0
M=D

// initialize pixel pointer R1
@SCREEN
D=A
@R1
M=D

(WRITE_LOOP)

// test progress
@R1
D=M
@KBD
D=A-D

// if write loop is complete:
@MAIN
D;JLE

// if write loop is incomplete, call clear|set:
@R0
D=M
@CLEAR
D;JEQ
@SET
D;JNE

(CLEAR)
@R1
A=M
M=0
@INCREMENT
0;JMP

(SET)
@R1
A=M
M=-1

(INCREMENT)
@R1
M=M+1

@WRITE_LOOP
0;JMP
