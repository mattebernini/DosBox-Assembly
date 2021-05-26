/*
    Scrivere un programma in Assembler che svolge i seguenti compiti
        1. richiede in ingresso due numeri naturali X ed Y in base 10, X a 6 cifre ed Y a 1 cifra, svolgendo
        gli opportuni controlli. In particolare:
            • Legge e fa eco di cifre in base 10, ignora e non fa eco di caratteri inattesi
            • Vengono accettate soltanto codifiche dal numero esatto di cifre
            • L’eco dei due input è fatto su due righe distinte
        2. se Y = 0 termina, altrimenti
        3. lascia una riga bianca ed esegue la divisione in base 10 di X per Y , per passaggi successivi,
        stampando i risultati intermedi formattati come da esempio.
        4. lascia una riga bianca e ritorna al punto 1.
    
    Si ponga attenzione alla formattazione di questo file, che fa parte delle specifiche.
*/
.GLOBAL _main
.INCLUDE "c:/amb_GAS/utility"

.DATA
X:          .FILL 6, 1
Y:          .BYTE 0

.TEXT
_main:
        NOP
        MOV $0, %ESI
inputX:
        CALL inchar
        CMP $'0', %AL 
        JB inputX
        CMP $'9', %AL
        JA inputX
        CALL outchar
        SUB $'0', %AL
        MOV %AL, X(%ESI)
        INC %ESI
        CMP $6, %ESI
        JNE inputX
inputY:
        CALL newline
        CALL inchar
        CMP $'0', %AL 
        JB inputY
        CMP $'9', %AL
        JA inputY
        CALL outchar
        SUB $'0', %AL
        MOV %AL, Y
        CALL newline
        CMP $0, %AL
        JE fine
        CALL newline

        # divisione sempre su 1 byte perchè q al max è 89 (7 bit)
        MOV $0, %ESI
        MOV Y, %BL      # divisore
        MOV $0, %DL     # conterrà il resto da molt per 10
divisione:
        MOV $0, %AH
        MOV X(%ESI), %AL
        PUSH %AX
        MOV $10, %AL
        MUL %DL
        MOV %AX, %DX
        POP %AX
        ADD %DX, %AX
        CALL stampa_op
        DIV %BL
        CALL stampa_ris
        MOV %AH, %DL
        INC %ESI
        CMP $6, %ESI
        JNE divisione
        CALL newline
        JMP _main
fine:
        RET

stampa_op:
        NOP
        CALL outdecimal_word
        PUSH %AX
        MOV $'/', %AL
        CALL outchar
        MOV %BL, %AL
        CALL outdecimal_byte
        MOV $':', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        POP %AX
        RET
stampa_ris:
        NOP
        PUSH %AX
        MOV $'q', %AL
        CALL outchar
        MOV $'=', %AL
        CALL outchar
        POP %AX
        CALL outdecimal_byte
        PUSH %AX
        MOV $' ', %AL
        CALL outchar
        MOV $'r', %AL
        CALL outchar
        MOV $'=', %AL
        CALL outchar
        POP %AX
        MOV %AL, %DH
        MOV %AH, %AL
        CALL outdecimal_byte
        MOV %DH, %AL
        CALL newline
        RET

/*
    output atteso:

    012594
    3

    0/3: q=0, r=0
    1/3: q=0, r=1
    12/3: q=4, r=0
    5/3: q=1, r=2
    29/3: q=9, r=2
    24/3: q=8, r=0

    012345
    0
*/

