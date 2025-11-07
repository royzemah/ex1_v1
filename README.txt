==============================
  TAU Compilation – EX1 Run Guide
==============================

This project (EX1 – Lexical Analysis) can be executed and tested in three different ways:

------------------------------------------------------------
1) Run with "make"
------------------------------------------------------------
Description:
- Simply run:
    make
- This compiles the project and then automatically runs:
    java -jar LEXER Input/input.txt Output/OutputTokens.txt

Requirements:
- The folders "Input/" and "Output/" must exist.
- The files:
      Input/input.txt
      Output/OutputTokens.txt
  must be present (an empty input file is also valid).
- OutputTokens.txt will be overwritten with the generated tokens.

------------------------------------------------------------
2) Run LEXER manually after build
------------------------------------------------------------
Description:
- After "make" completes successfully, you can run the lexer
  manually on any input and output existing file paths.

Example:
    java -jar LEXER input1.txt output1.txt

Notes:
- The jar file is created by the Makefile.
- You can use any valid input text file.
- The output file will be created (or overwritten) automatically.

------------------------------------------------------------
3) Run using the Nova self-check (official test script)
------------------------------------------------------------
Description:
- Use the TAU-provided self-check environment on Nova.

Steps (on your Mac):
    0. Connect TAU VPN (Palo Alto GlobalProtect)
    1. Ensure both files are on your Desktop:
           206090128.zip
           self-check-ex1.zip
    2. Upload to Nova:
           cd ~/Desktop
           scp 206090128.zip self-check-ex1.zip royzemah@nova.cs.tau.ac.il:~
    3. Connect to Nova:
           ssh royzemah@nova.cs.tau.ac.il
    4. (Optional) Clean old runs:
           rm -rf expected_output tests __MACOSX self-check-output ex1 ids.txt self-check.py self-check-ex1.zip
    5. Unzip the self-check package:
           unzip self-check-ex1.zip
    6. Run the self-check:
           python3 self-check.py

Expected success message:
    All tests passed
    OK to submit :)

------------------------------------------------------------
End of README
------------------------------------------------------------
