/*    
    Scrivere un programma che:
    1. legge con eco da tastiera una stringa di max 20 caratteri
       terminata da un ritorno carrello;
    2. stampa la stringa sostituendo ogni cifra decimale
       con il nome della cifra, contornato da uno o piu' spazi; es. la stringa
         a12bc
       viene stampata come
         a uno     due     bc
    3. se la stringa inserita conteneva almeno un numero torna al passo 1,
       altrimenti termina.
     NB: Si consiglia di allineare tutte le stringhe da stampare sullo stesso numero di caratteri 
         calcolato sul testo di lunghezza massima
*/

.GLOBAL _main

.INCLUDE "c:/amb_GAS/utility"

.DATA
stringa:        .FILL 20, 1
zero:       .ASCII " zero    "
uno:		.ASCII " uno     "
due:		.ASCII " due     "
tre:		.ASCII " tre     "
quattro:    .ASCII " quattro "
cinque:		.ASCII " cinque  "
sei:		.ASCII " sei     "
sette:      .ASCII " sette   "
otto:       .ASCII " otto    "
nove:       .ASCII " nove    "
numero:     .LONG zero, uno, due, tre, quattro, cinque, sei, sette, otto, nove

.TEXT
_main:            
            NOP
            MOV $0, %ECX     # CL conta caratteri stringa
            MOV $0, %ESI
leggi:
            CALL inchar
            CMP $0x0d, %AL
            JE punto_due
            CALL outchar
            MOV %AL, stringa(%ESI)
            INC %ESI
            INC %CL
            CMP $20, %CL
            JNE leggi
punto_due:
            CALL newline
            MOV $0, %ESI
            MOV $0, %DL     # conta numeri stampati
ciclo:
            CMPB $'0', stringa(%ESI)
            JB stampa_lettera
            CMPB $'9', stringa(%ESI)
            JA stampa_lettera
            INC %DL
            MOV $0, %EBX
            MOV stringa(%ESI), %BL
            SUB $'0', %BL
            MOV numero(,%EBX, 4), %EDI 
            MOV %EDI, %EBX
            PUSH %CX
            MOV $9, %CX
            CALL outmess
            POP %CX
            JMP fine_ciclo
stampa_lettera:
            MOV stringa(%ESI), %AL
            CALL outchar
fine_ciclo:
            INC %ESI
            CMP %ESI, %ECX
            JNE ciclo

            CALL newline
            CMP $0, %DL
            JNE _main
fine:
            RET

