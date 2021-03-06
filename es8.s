/*
    Scrivere un programma che si comporta come segue:
    1. legge con eco da tastiera una sequenza di cinque cifre binarie, da interpretare come
       la rappresentazione di un numero intero n in complemento a due. Il programma deve fare
       i necessari controlli in modo da accettare SOLTANTO le codifiche ASCII di ESATTAMENTE
       5 cifre binarie;
    2. se n è positivo, stampa la riga
       n = <+...+>
       altrimenti, se n è negativo, stampa la riga:
       n = <-...->
       dove il numero di caratteri '+' o '-' è uguale a ABS(n);
    3. se n è uguale a zero termina, altrimenti torna al passo 1.
*/

.GLOBAL _main
.INCLUDE "c:/amb_GAS/utility"

.DATA

.TEXT
_main:  
            NOP
            MOV $4, %CL     # conta 
            MOV $0, %BL     # contiene n
input:
            CALL inchar
            CMP $'0', %AL
            JB input
            CMP $'1', %AL
            JA input
            CALL outchar

            SUB $'0', %AL
            SHL %CL, %AL
            OR %AL, %BL 
            DEC %CL 
            CMP $0, %CL
            JGE input

            CMP $0, %BL
            JE fine
            CALL newline
            MOV %BL, %AL
            CALL outdecimal_byte
                        # n=5, b=2, ca2 --> [-2^5/2; 2^5/2 - 1] --> [-16; 15]
            CMP $15, %BL
            JBE positivo
negativo:
            MOV $'-', %BH
            OR $0b11100000, %BL		# estendo da 5 a 8 bit la rappresentazione del numero intero
			NEG %BL	
            JMP stampa     
positivo:
            MOV $'+', %BH     
stampa:
            MOV %BL, %CL
            CALL newline
            MOV $'n', %AL
            CALL outchar
            MOV $'=', %AL
            CALL outchar
            MOV $' ', %AL
            CALL outchar
            MOV $'<', %AL
            CALL outchar
ciclo_segni:
            MOV %BH, %AL
            CALL outchar
            DEC %CL
            JNZ ciclo_segni

            MOV $'>', %AL
            CALL outchar 
            
            CALL newline
            JMP _main
fine:
            RET

