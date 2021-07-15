/*
    Scrivere un programma che si comporta come segue:
    1. legge con eco da tastiera due numeri naturali A e B di 2 cifre in base 10
    2. se A e B non sono entrambi compresi tra 2 e 20, estremi inclusi, termina
    3. altrimenti, lascia una riga vuota e stampa a video un rettangolo di base A ed altezza B
    così fatto:
    • se A ≥ B, la cornice è fatta di caratteri 0 e l’interno di 1
    • altrimenti, la cornice è fatta di caratteri 1 e l’interno di 0
    4. lascia una riga vuota e ritorna al punto 1.
    Nota: durante ogni lettura, un qualunque carattere inatteso dovrà essere ignorato, e il
    programma dovrà rimanere in attesa di un carattere corretto.
*/

.GLOBAL _main

.INCLUDE "c:/amb_GAS/utility"

.DATA
A:      .BYTE 0
B:      .BYTE 0

.TEXT
_main:            
            NOP
in_A1:
            MOV $0, %EAX
            CALL inchar
            CMP $'0', %AL
            JB in_A1
            CMP $'9', %AL
            JA in_A1
            CALL outchar
            SUB $'0', %AL
            MOV $10, %BL
            MUL %BL
            MOV %AL, A 
in_A2:
            MOV $0, %EAX
            CALL inchar
            CMP $'0', %AL
            JB in_A2
            CMP $'9', %AL
            JA in_A2
            CALL outchar
            SUB $'0', %AL
            ADD %AL, A 

            CALL newline
in_B1:
            MOV $0, %EAX
            CALL inchar
            CMP $'0', %AL
            JB in_B1
            CMP $'9', %AL
            JA in_B1
            CALL outchar
            SUB $'0', %AL
            MOV $10, %BL
            MUL %BL
            MOV %AL, B
in_B2:
            MOV $0, %EAX
            CALL inchar
            CMP $'0', %AL
            JB in_B2
            CMP $'9', %AL
            JA in_B2
            CALL outchar
            SUB $'0', %AL
            ADD %AL, B
cond_uscita:
            CMPB $2, A
            JB fine
            CMPB $20, A
            JA fine
            CMPB $2, B
            JB fine
            CMPB $20, B
            JA fine

            CALL newline
            CALL newline
            # rettangolo di base A ed altezza B
            MOV A, %BL
            MOV B, %BH 
            MOV $0, %CH     # conta altezza
            CMP %BH, %BL
            JA cornice0
            MOV $'1', %DL         # cornice
            MOV $'0', %DH         # interno
cornice0:
            MOV $'0', %DL         # cornice
            MOV $'1', %DH         # interno

            SUB $2, %BH
            CALL stampa_cornice
ciclo_altezza:
            CALL stampa_interno
            INC %CH
            CMP %BH, %CH
            JNE ciclo_altezza
            CALL stampa_cornice

            CALL newline
            CALL newline
            JMP _main
fine:
            RET

# sottoprogramma 
stampa_cornice:
            NOP
            MOV %DL, %AL
            MOV $0, %CL     # conta base
ciclo_cornice:
            CALL outchar
            INC %CL
            CMP %BL, %CL
            JNE ciclo_cornice
            CALL newline
            RET

# sottoprogramma 
stampa_interno:
            NOP
            MOV %DL, %AL
            CALL outchar
            MOV %DH, %AL
            MOV $2, %CL     # conta base
ciclo_interno:
            CALL outchar
            INC %CL
            CMP %BL, %CL
            JNE ciclo_interno
            MOV %DL, %AL
            CALL outchar
            CALL newline
            RET

    