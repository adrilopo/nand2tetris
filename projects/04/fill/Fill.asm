// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

(LISTEN)
  @KBD
  D=M
  @CLEAR
  D;JEQ  // If KBD=0 goto CLEAR
  @BLACK
  0;JMP  // Otherwise goto BLACK

(BLACK)
  @count
  M=0    // Initialize count=0
(LOOP-BLACK)
  @count
  D=M  // D=count
  @8191
  D=A-D  // D=8191-count (The screen consists of 256*32=8192 16-bit words). 
  @LISTEN
  D; JLT  // If count>8192 goto LISTEN
  @count
  D=M    // D=count
  @SCREEN
  A=D+A  // A=SCREEN+count
  M=-1   // Set every pixel in the row to 1
  @count 
  M=M+1  // count=count-1
  @LOOP-BLACK
  0;JMP  // goto LOOP-BLACK

(CLEAR)
  @count
  M=0
(LOOP-CLEAR)
  @count
  D=M  // D=count
  @8191
  D=A-D  // D=8191-count (The screen consists of 256*32=8192 16-bit words).
  @LISTEN
  D; JLT  // If count>8191 goto LISTEN
  @count
  D=M    // D=count
  @SCREEN
  A=D+A  // A=SCREEN+count
  M=0   // Set every pixel in the row to 0
  @count 
  M=M+1  // count=count-1
  @LOOP-CLEAR
  0;JMP  // goto LOOP-CLEAR
   
