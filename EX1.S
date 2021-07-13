/*
    Scrivere un programma che si comporta come segue:

    1. legge con eco da tastiera una stringa di lettere minuscole di al piu' 256 caratteri
    terminata da ritorno carrello;
    2. se la stringa è vuota, termina. 
    3. Altrimenti, se la stringa non è vuota
    a. stampa la vocale che occorre il maggior numero di volte nella stringa (in caso
        di ugual numero di occorrenze, vale l'ordine alfabetico);
    b. torna al punto 1.
    
    Esempio
    aabcddedhebbeecuuuu
    e
*/

.GLOBAL _main

.INCLUDE "c:/amb_GAS/utility"

.DATA
conta:      .FILL 4, 2
vocali:     .ASCII "aeiou"

.TEXT
_main:
            NOP
            MOV $0, %ESI
            MOV $256, %ECX
input:
            CALL inchar
            CMP $0x0D, %AL
            JE punto2
            CMP %ESI, %ECX
            JB punto2
            CALL outchar
            CMP $'a', %AL
            JE inc_a
            CMP $'e', %AL
            JE inc_e
            CMP $'i', %AL
            JE inc_i
            CMP $'o', %AL
            JE inc_o
            CMP $'u', %AL
            JE inc_u
fine_conta:
            INCW conta(,%EDI, 2)
            INC %ESI
            JMP input
inc_a:
            MOV $0, %EDI
            JMP fine_conta
inc_e:
            MOV $1, %EDI 
            JMP fine_conta
inc_i:
            MOV $2, %EDI 
            JMP fine_conta
inc_o:
            MOV $3, %EDI
            JMP fine_conta
inc_u:
            MOV $4, %EDI
            JMP fine_conta
punto2:
            CMP $0, %ESI
            JE fine
            CALL newline
            MOV $0, %ESI
            MOV $1, %EDI
ciclo:
            CMP $5, %EDI
            JE stampa
            MOV conta(,%ESI, 2), %BX
            CMP conta(,%EDI, 2), %BX
            JAE uno     # a > e
            MOV conta(,%EDI, 2), %BX
uno:
            INCL %EDI
            JMP ciclo
stampa:
            MOV vocali(%EDI), %AL
            CALL outchar
            CALL newline
            JMP _main
fine:
            RET
