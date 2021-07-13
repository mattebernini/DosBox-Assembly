/*
    Scrivere un programma che si comporta come segue:

    1. legge con eco da tastiera una stringa di lettere minuscole 
       terminata da ritorno carrello;
    2. legge con eco da tastiera una lettera minuscola;
    3. stampa sulla riga il numero di occorrenze nella stringa della lettera;
    4. se il numero di occorrenze è maggiore di uno torna al passo 2, altrimenti termina.

    Esempio:
    aabcdddhbbc
    a 2
    d 3
    f 0
*/

.GLOBAL _main

.INCLUDE "c:/amb_GAS/utility"

.DATA
conta:      .FILL 26, 1, 0      # a=97 --> z=122


.TEXT
_main:            
            NOP
            MOV $0, %CL
            MOV $0, %EAX
leggi:
            CALL inchar
            CMP $13, %AL        # ritorno carrello
            JE occorrenze
            CMP $'a', %AL
            JB leggi
            CMP $'z', %AL
            JA leggi

            CALL outchar
            MOV %EAX, %ESI
            SUB $97, %ESI
            INCB conta(%ESI)
            JMP leggi
occorrenze:
            CALL newline
            MOV $0, %EAX
            CALL inchar
            CMP $'a', %AL
            JB occorrenze
            CMP $'z', %AL
            JA occorrenze
            CALL outchar
            MOV %EAX, %ESI
            MOV $' ', %AL
            CALL outchar
            SUB $97, %ESI    
            MOV conta(%ESI), %AL
            CALL outdecimal_byte
            CMP $0, %AL
            JNE occorrenze     
fine:
            RET

        