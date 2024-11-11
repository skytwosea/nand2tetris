// screen initialization: set write-bit to 0 (clear mode)
@R1
M=0

(WRITE_INIT)        // set R0 pixel pointer
    @SCREEN
    D=A
    @R0
    M=D

(WRITE_LOOP)        // test -> set -> increment -> loop
    // test
    @R0
    D=M
    @KBD
    D=A-D
    @PASS
    D;JGT

    // on fail
    @R1
    D=M
    @WAIT_LOW
    D;JEQ           // jump to wait_low if M[R1] = 0
    @WAIT_HIGH
    D;JLT           // jump to wait_low if M[R1] = -1

    // on pass, call write function
    (PASS)
    @R1
    D=M
    @CLEAR
    D;JEQ
    @SET
    D;JLT

    // increment
    (INCREMENT)
    @R0
    M=M+1

    // loop
    @WRITE_LOOP
    0;JMP

(WAIT_LOW)
    @KBD
    D=M
    @WAIT_LOW
    D;JEQ
    @R1
    M=-1
    @WRITE_INIT
    0;JMP

(WAIT_HIGH)
    @KBD
    D=M
    @WAIT_HIGH
    D;JNE
    @R1
    M=0
    @WRITE_INIT
    0;JMP

(CLEAR)
    @R0
    A=M
    M=0
    @INCREMENT
    0;JMP

(SET)
    @R0
    A=M
    M=M-1
    @INCREMENT
    0;JMP
