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
X:          .BYTE 0
Y:          .BYTE 0

.TEXT
_main:
        MOV $0, %EAX
        MOV $0, %ECX
input_x:
        CALL inchar
        CMP $'0', %AL
        JB input_x
        CMP $'9', %AL
        JA input_x
        CALL outchar
        SUB $'0', %AL
        MOV %AL, X(%ECX, 1)
        INC %ECX
        CMP $6, %ECX
        JNE input_x

        CALL newline
input_y:
        CALL inchar
        CMP $'0', %AL
        JB input_y
        CMP $'9', %AL
        JA input_y
        CALL outchar
        SUB $'0', %AL
        MOV %AL, Y
        
        CALL newline
        CMP $0, %AL
        JE fine
        CALL newline

        MOV $0, %EAX
        MOV $5, %ECX
        MOV X(%ECX, 1), %AL
moltiplica:
        CMP $0, %EAX
        JE termina
        MOV $0, %EBX
        MOV Y, %BL
        CALL outdecimal_long
        PUSH %EAX
        MOV $'/', %AL
        CALL outchar
        MOV $':', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        POP %EAX
        
        DIV %EBX

        PUSH %EAX
        MOV $'q', %AL
        CALL outchar
        MOV $'=', %AL
        CALL outchar
        POP %EAX
        CALL outdecimal_long
        PUSH %EAX
        MOV $',', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOV $'r', %AL
        CALL outchar
        MOV $'=', %AL
        CALL outchar
        MOV %EDX, %EAX
        CALL outdecimal_long
        POP %EAX
        CMP $0, %ECX
        JE termina
        DEC %ECX
        MOV $0, %EAX
        MOV X(%ECX, 1), %AL
        PUSH %EAX
        MOV $10, %EAX
        MUL %EDX
        POP %EAX
        ADD %EDX, %EAX
        JMP moltiplica
termina:
        CALL newline
        JMP _main

fine:
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

