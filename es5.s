/*
     Scrivere un programma che si comporta come segue:
     1) stampa un punto interrogativo e legge con eco da tastiera
        un numero naturale A in base 10, sotto l'ipotesi che stia su 16 bit
     2) se il numero è minore o uguale ad 1, termina
     3) altrimenti, stampa la sua scomposizione in fattori primi,
        cioe' una lista di righe x^y, intendendo che il fattore primo x
        e' contenuto in A alla sua potenza y-esima, con x>=2, y>=1.
     4) attende la pressione di un tasto e termina.

     Esempio:

    ?338
    2^1
    13^2

    ?199
    199^1

    ?1
    [terminazione]
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

        CMP $1, %AX
        JBE fine

        MOV $2, %BX
# divido AX/BX
# se resto == 0 allora CX++ e ripeto divisione
# sennò annullo divisione e se CX != 0 stampo BX^CX, incremento BX e ripeto
controllo:
        CMP %AX, %BX
        JA nl
        MOV $0, %CX
fatt:
        MOV %AX, %SI
        MOV $0, %DX 
        DIV %BX
        CMP $0, %DX
        JNE non_div
        INC %CX
        JMP fatt
non_div:
        MOV %SI, %AX
        CMP $0, %CX
        JA stampa
        INC %BX 
        JMP controllo
stampa:
        PUSH %AX
        MOV %BX, %AX
        CALL outdecimal_word
        MOV $'^', %AL
        CALL outchar
        MOV %CX, %AX
        CALL outdecimal_word
        CALL newline
        MOV $0, %CX
        INC %BX  
        POP %AX
        JMP controllo
nl:
        CALL newline
        CALL newline
        JMP _main
fine:
        RET

