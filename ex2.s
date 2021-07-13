/*
    Scrivere un programma assembler che si comporta come segue:

    1. stampa un punto interrogativo e legge da tastiera una cifra decimale 
    2. se la cifra letta X e' uguale a 0 termina, altrimenti
    3. stampa un triangolo isoscele di base 2X, in cui la riga i-esima 
    e' ottenuta stampando 2i-1 volte il carattere ASCII corrispondente 
    al numero i, preceduto da un numero opportuno di spazi.
    4. ritorna al punto 1.

    Esempio:
    ?5

    1
    222
    33333
    4444444
    555555555

    ?3

    1
    222
    33333
*/

.GLOBAL _main

.INCLUDE "c:/amb_GAS/utility"

.DATA

.TEXT
_main:      
            NOP
            MOV $'?', %AL
            CALL outchar
            CALL indecimal_byte
            CMP $0, %AL
            JE fine
            CALL newline

            MOV %AL, %DL    # salvo X+1 in DL per il cmp di termina
            INC %DL
            MOV $1, %CH     # conta righe
quante:
            CMP %CH, %DL
            JE termina
            MOV %CH, %BL    # BL contiene numero stampe 2*CH-1
            SHL %BL
            DEC %BL
            MOV $0, %CL     # conta numeri stampati
ciclo:
            MOV %CH, %AL
            CALL outdecimal_byte
            INC %CL
            CMP %CL, %BL
            JNE ciclo

            CALL newline
            INC %CH
            JMP quante
            
termina:
            CALL newline
            JMP _main
fine:
            RET

    