/*
    Scrivere un programma Assembler che si comporta come segue:
    1. legge da tastiera un numero naturale A in base 10,
        A sta su 32 bit,
    2. se A è nullo termina, altrimenti:
    3. stampa A in tutte le basi da 2 a 9 su righe successive
       premettendo a ciascuna sequenza la base a cui si riferisce
    4. torna al punto 1
*/

.GLOBAL _main
.INCLUDE "c:/amb_GAS/utility"

.DATA
A:                  .LONG 0
base_corrente:      .FILL 32, 1     # A in base 2 al massimo 32 cifre

.TEXT
_main:
        NOP
        MOV $'?', %AL
        CALL outchar
        CALL indecimal_long
        CMP $0, %EAX
        JE fine
        MOV %EAX, A
    # div&mod
        MOV $1, %EBX
nuova_base:
        MOV $0, %ESI
        INC %EBX
        CALL newline
        CMP $10, %EBX
        JE _main
        MOV %EBX, %EAX
        CALL outdecimal_long
        MOV $':', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOV A, %EAX
divisione:
        MOV $0, %EDX
        DIV %EBX
        MOV %DL, base_corrente(%ESI)
        INC %ESI
        CMP $0, %EAX
        JNE divisione
stampa:
        MOV base_corrente(%ESI), %AL
        CALL outdecimal_byte
        DEC %ESI
        JZ nuova_base
        JMP stampa
fine:
        RET

