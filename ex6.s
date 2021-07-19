/*
    Scrivere un programma che si comporta come segue:
    1. legge da tastiera e stampa su una riga dieci cifre decimali
    2. legge un carattere da tastiera senza eco
    3. in base al carattere letto, compie una delle seguenti operazioni:
    s : ruota di una posizione a sinistra l’ultima stringa stampata e la stampa su una
    nuova riga, quindi torna al punto 2;
    d : ruota di una posizione a destra l’ultima stringa stampata e la stampa su una nuova
    riga, quindi torna al punto 2;
    r : inverte l’ordine degli elementi dell’ultima stringa stampata e la stampa su una
    nuova riga, quindi torna al punto 2;
    q : termina;

    Nota: durante ogni lettura, un qualunque carattere inatteso dovrà essere ignorato, e il
    programma dovrà rimanere in attesa di un carattere corretto.

    Esempio
    Assumendo che la sequenza di caratteri battuti sulla tastiera sia
    0003334567
    sss ?d! srsq
    Sullo schermo dovrà comparire la seguente sequenza di stringhe:
    0003334567
    0033345670
    0333456700
    3334567000
    0333456700
    3334567000
    0007654333
    0076543330
*/

.GLOBAL _main

.INCLUDE "c:/amb_GAS/utility"

.DATA
stringa:      .FILL 10, 1, 0

.TEXT
_main:            
            NOP
            MOV $0, %ESI 
leggi:
            CALL inchar
            CMP $'0', %AL
            JB leggi
            CMP $'9', %AL
            JA leggi
            CALL outchar
            MOV %AL, stringa(%ESI)
            INC %ESI
            CMP $10, %ESI
            JNE leggi
comando:
            CALL newline
            CALL inchar
            CMP $'s', %AL
            JE ruota_sx
            CMP $'d', %AL
            JE ruota_dx
            CMP $'r', %AL
            JE palindroma
            CMP $'q', %AL
            JE fine
            JMP comando
# s
ruota_sx:
            MOV $9, %ESI
            MOV $'0', %BL
ciclo_ruota_sx:
            MOV stringa(%ESI), %DL
            MOV %BL, stringa(%ESI)
            MOV %DL, %BL
            DEC %ESI
            CMP $0, %ESI
            JNE ciclo_ruota_sx
            MOV %BL, stringa(%ESI) 
            JMP stampa
# d
ruota_dx:
            MOV $0, %ESI
            MOV $'0', %BL
ciclo_ruota_dx:
            MOV stringa(%ESI), %DL
            MOV %BL, stringa(%ESI)
            MOV %DL, %BL
            INC %ESI
            CMP $10, %ESI
            JNE ciclo_ruota_dx
            JMP stampa
# r
palindroma:
            MOV $0, %ESI
            MOV $9, %EDI
            MOV $'0', %BL
ciclo_palindroma:
            MOV stringa(%ESI), %DL
            MOV stringa(%EDI), %BL
            MOV %BL, stringa(%ESI)
            MOV %DL, stringa(%EDI)
            DEC %EDI
            INC %ESI
            CMP $5, %ESI
            JNE ciclo_palindroma
            JMP stampa
stampa:
            CALL stampa_stringa
            JMP comando
fine:       
            RET



# sottoprogramma
stampa_stringa:
            NOP
            MOV $0, %ESI 
ciclo_stampa:
            MOV stringa(%ESI), %AL
            CALL outchar
            INC %ESI
            CMP $10, %ESI
            JNE ciclo_stampa 
            CALL newline
            RET
