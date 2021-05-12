/*
Scrivere un programma che si comporta come segue:
1. legge con eco da tastiera le rappresentazioni A di un intero a, e B di un intero b, in complemento
alla radice su 2 cifre in base dieci, facendo i dovuti controlli. I due numeri devono essere stampati
su righe separate.
2. se l’intero c = a + b è rappresentabile in complemento alla radice su 2 cifre in base dieci: stampa, su
una riga separata, la rappresentazione C di c, lascia una riga vuota e ritorna al passo 1. Altrimenti,
termina.
Nota: per ”dovuti controlli” si intende che il programma ignora e non fa eco di caratteri inattesi.
Vengono accettate soltanto le codifiche di esattamente 2 cifre decimali.
*/

.GLOBAL _main
.INCLUDE "c:/amb_GAS/utility"

.DATA
A:      .BYTE 0
B:      .BYTE 0
C:      .BYTE 0

.TEXT
_main:
        NOP
        MOV $0, %ECX
        MOV $0, %EAX
input:
        CMP $4, %CL 
        JE due
        CALL inchar
        CMP $'0', %AL
        JB input
        CMP $'9', %AL
        JA input
        CALL outchar
        
        CMP $2, %CL
        JA assegna_B
assegna_A:
        ADD $'0', %AL
        MOV %AL, A(%ECX, 1)
        INC %CL
        CMP $2, %CL
        JE nl 
        JMP input
assegna_B:
        ADD $'0', %AL
        MOV %ECX, %EDX
        SUB $2, %EDX
        MOV %AL, B(%EDX, 1)
        INC %CL 
        JMP input
nl:
        CALL newline
        JMP input
due: 
        # rappresentabile in complemento alla radice su 2 cifre in base dieci vuol dire:
        # faccio somma C[0] = A[0]+B[0] C[1] = riporto+A[1]*10+B[1]*10, C[1] <= 9

        MOV $0, %DL     # contiene riporto
        MOV A, %AL
        MOV B, %BL
        ADD %BL, %AL
        CMP $9, %AL
        JA riporto
        MOV %AL, C
        JMP seconda_cifra
riporto:
        SUB $10, %AL
        MOV %AL, C 
        INC %DL
seconda_cifra:
        MOV $1, %ESI 
        MOV A(%ESI), %AL
        MOV B(%ESI), %BL
        ADD %BL, %AL 
        ADD %DL, %AL
        CMP $9, %AL
        JA errore
        MOV %AL, C(%ESI, 1)

        MOV C, %AL
        CALL outdecimal_byte
        MOV C(%ESI, 1), %AL
        CALL outdecimal_byte
        CALL newline
        JMP _main
errore:
        CALL newline
        CALL newline
        CALL newline
        CALL newline
fine:
        RET
/*
74
90
64

42
99
41

50
50

*/

 