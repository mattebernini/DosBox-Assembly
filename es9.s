/*
    ===========================================================
    Scrivere un programma Assembler che si comporta come segue:
    1. richiede in ingresso un numero decimale X, assumendo che stia su
       16 bit.
    2. Se X=0 termina, altrimenti
    3. Stampa X in base 4 e ritorna al punto 1

    Es: 
    ?48
    300
    ?65535
    33333333
    ===========================================================
*/

.GLOBAL _main
.INCLUDE "c:/amb_GAS/utility"

.DATA

.TEXT
_main:  
            NOP
            MOV $'?', %AL
            CALL outchar
            CALL indecimal_word
            CALL newline
            CMP $0, %AX
            JE fine

            MOV $4, %BX
            MOV $0, %CL
div_mod:
            MOV $0, %DX
            DIV %BX
            PUSH %DX
            INC %CL
            CMP $0, %AX
            JNE div_mod
stampa:
            POP %AX
            CALL outdecimal_word
            DEC %CL
            JNZ stampa

            CALL newline
            JMP _main
fine:
            RET


            