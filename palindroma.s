/*
    verificare se una stringa di 8 bit in input è palindroma,
    scrivere in output il risultato, se la stringa è 0 termina
*/


.GLOBAL _main
.INCLUDE "c:/amb_GAS/utility"

.DATA
msg_ok:     .ASCII "palindroma"
msg_no:     .ASCII "non palindroma"

.TEXT
_main:  
            NOP
            MOV $0, %CL
            MOV $0, %BL     # contiene stringa
input:
            CALL inchar
            CMP $'0', %AL
            JB input
            CMP $'1', %AL
            JA input
            CALL outchar
            SUB $'0', %AL
            SHL %CL, %AL
            OR %AL, %BL
            INC %CL
            CMP $8, %CL
            JNE input

            CALL newline
            CMP $0, %BL
            JE fine

            MOV $1, %CL
controllo:
            MOV $0, %AH
            MOV %BL, %AL
            RCR %CL, %AL
            ADC $0, %AH 
            MOV %BL, %AL
            RCL %CL, %AL
            ADC $0, %AH 
            CMP $1, %AH     # se AH=1 i due bit simmetrici son diversi
            JE non_palindroma
            INC %CL
            CMP $4, %CL
            JNE controllo
palindroma:
            LEA msg_ok, %EBX
            MOV $10, %CX
            JMP stampa
non_palindroma:
            LEA msg_no, %EBX
            MOV $14, %CX
stampa:
            CALL outmess
            CALL newline
            JMP _main            
fine:
            RET

