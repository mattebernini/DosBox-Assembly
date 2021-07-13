# calcola media del vettore

.GLOBAL _main

.INCLUDE "c:/amb_GAS/utility"

.DATA
vettore:          .BYTE 1, 2, 3, 18, 5, 6, 7 

.TEXT
_main:
            NOP

            CLD
            LEA vettore, %ESI
            MOV $7, %ECX
            MOV $0, %BX
            MOV $0, %DL
ciclo:
            LODSB
            ADD %AL, %BL
            CMP $0, %ECX
            JNE ciclo

            MOV %BX, %AX
            MOV $7, %BX
            MOV $0, %DX
            DIV %BX
            CALL outdecimal_word
fine:
            RET


