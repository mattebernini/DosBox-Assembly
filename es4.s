/*
Scrivere un programma che si comporta come segue:
    1. legge con eco da tastiera una stringa di lettere minuscole terminata da ritorno carrello;
    2. legge con eco da tastiera una lettera minuscola;
    3. stampa sulla riga il numero di occorrenze nella stringa della lettera;
    4. se il numero di occorrenze è maggiore di uno torna al passo 2, altrimenti termina.
    NB: si assuma che la stringa possa essere di lunghezza qualunque, 
    ma il numero di occorrenze diciascuna lettera stia su 8 bit.

    Esempio:
    aabcdddhbbc
    a 2
    d 3
    f 0
*/

.GLOBAL _main
.INCLUDE "C://amb_GAS/utility"

.DATA
stringa:    .BYTE 0     # vettore con codifica ascii

.TEXT
_main:
            NOP
            MOV $0, %ECX
leggi:
            CALL inchar
            CMP $0x0D, %AL
            JE lettera
            CMP $'a', %AL
            JB leggi
            CMP $'z', %AL
            JA leggi
            CALL outchar
            MOV %AL, stringa(%ECX, 1)
            INC %ECX
            JMP leggi
lettera:
            CALL newline
            CALL inchar
            CMP $'a', %AL
            JB lettera
            CMP $'z', %AL
            JA lettera
            CALL outchar

            MOV $0, %ESI
            MOV $0, %EDX
conta:
            CMP %ECX, %ESI
            JE termina
            CMP stringa(%ESI), %AL
            JE match
            INC %ESI
            JMP conta
match:
            INC %EDX
            INC %ESI
            JMP conta
termina:
            MOV $' ', %AL
            CALL outchar
            MOV %EDX, %EAX
            CALL outdecimal_long
            CMP $0, %EDX
            JNE lettera
fine:
            RET

