/*
    dati due array di 10 word in memoria 
    stampare n° elementi diversi con la stessa posizione
*/
.GLOBAL _main

.INCLUDE "c:/amb_GAS/utility"

.DATA
array1:          .WORD 51, 14, 3, 4, 5, 87, 12 
array2:          .WORD 1, 2, 3, 18, 5, 6, 7 

.TEXT
_main:
            NOP
            CLD
            LEA array1, %ESI
            LEA array2, %EDI
            MOV $7, %ECX
            MOV $0, %AL
ciclo:
            REPE CMPSW 
            CMP $0, %ECX
            JL stampa
            INC %AL
            CMP $0, %ECX
            JNE ciclo
stampa:
            CALL outdecimal_byte
fine:
            RET


