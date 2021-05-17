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
A:      .FILL 2, 1
B:      .FILL 2, 1
C:      .FILL 3, 1
a:      .WORD 0
b:      .WORD 0


.TEXT
_main:
        NOP
        MOV $0, %ECX
        MOV $0, %ESI
input_A:
        CMP $4, %ECX
        JE due
        CALL inchar
        CMP $'0', %AL
        JB input_A
        CMP $'9', %AL
        JA input_A
        CMP $2, %ECX
        JAE nl
        CALL outchar
        MOV %AL, A(%ECX)
        INC %ECX
        JMP input_A
nl:
        CMP $2, %ECX
        JNE input_B 
        CALL newline
input_B:
        CALL outchar
        MOV %ECX, %ESI
        SUB $2, %ESI
        MOV %AL, B(%ESI)
        INC %ECX
        JMP input_A
due:
        CALL newline
        MOV $0, %ESI
        MOV $0, %EBX
        # compl alla radice b=10, n=2 --> a appartiene a [-50, 49], se A < 50 è positivo
        # c sarà rappresentabile solo se appartiene a [-50, 49]
        # faccio la somma C = |A+B|modulo1000 su 3 cifre in base10, se la 3° cifra != 0 è Overflow
        MOV A(%ESI), %AL
        ADD B(%ESI), %AL
        CMP $10, %AL
        JB secondo_addendo
        SUB $10, %AL
        MOV $1, %BL
secondo_addendo:
        MOV %AL, C(%ESI)
        INC %ESI
        MOV A(%ESI), %AL
        ADD %BL, %AL
        ADD B(%ESI), %AL
        CMP $10, %AL
        JB stampa
        XOR $1, %BL
        CMP $1, %BL
        JE fine
stampa:
        MOV %AL, C(%ESI)

        MOV $0, %ESI
        MOV C(%ESI), %AL
        CALL outdecimal_byte
        INC %ESI
        MOV C(%ESI), %AL
        CALL outdecimal_byte
        CALL newline
        CALL newline
        JMP _main
fine:
        CALL newline
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

 