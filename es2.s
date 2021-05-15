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
        MOV $0, %ECX
input:
        CALL inchar
        CMP $'0', %AL 
        JB input
        CMP $'9', %AL
        JA input
        CMP $6, %ECX
        JE controllo_Y
        CALL outchar
        SUB $'0', %AL
        MOV %AL, X(%ECX)
        INC %ECX
        JMP input
controllo_Y: 
        CALL newline
        CALL outchar
        CMP $'0', %AL 
        JE fine
        SUB $'0', %AL
        MOV %AL, Y
        CALL newline
        CALL newline
        
        MOV $0, %ESI 
        MOV $0, %EDX
        MOV $10, %DH
divisione:
        MOV Y, %BL      # divisore
        MOV $0, %AX
        MOV X(%ESI), %AL
        ADD %DL, %AL
        MOV %AL, %CL    # dividendo in CL
        DIV %BL
        MOV %AL, %CH    # q in CH
        CALL stampa
        MOV %AH, %DL    # resto * 10
        MUL %DH
        MOV %AL, %DL    # resto in DL
        CMP $5, %ESI
        JE nl
        INC %ESI 
        JMP divisione
nl:
        CALL newline
        CALL newline
        JMP _main
fine:
        RET

# sottoprogramma
stampa:
        MOV %CL, %AL
        CALL outdecimal_byte
        MOV $'/', %AL
        CALL outchar
        MOV Y, %AL
        CALL outdecimal_byte
        MOV $':', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOV $'q', %AL
        CALL outchar
        MOV $'=', %AL
        CALL outchar
        MOV %CH, %AL
        CALL outdecimal_byte
        MOV $',', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOV $'r', %AL
        CALL outchar
        MOV $'=', %AL
        CALL outchar
        MOV %AH, %AL
        CALL outdecimal_byte
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

