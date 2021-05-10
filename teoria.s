/*
    REGISTRI
    EIP ed EF da non toccare
    ESP punta all'ultima locazione della pila

*/

.GLOBAL _main

.INCLUDE "c:/amb_GAS/utility"

.DATA
x:                          .BYTE 5                 # x è uno pseudonimo del suo indirizzo
vett_b:                     .BYTE 1, 2, 3, 4, 5     # vettore di byte
vett_l:                     .LONG 6, 7, 8, 9, 10    # vettore di long
mess:                       .ASCII "numero"      # stringa
vett_byte:                  .FILL 10, 1             # vettore di byte a 10 componenti non ancora inizializzate
vett_word:                  .FILL 10, 2             # vettore di word a 10 componenti non ancora inizializzate
vett_long:                  .FILL 10, 4             # vettore di long a 10 componenti non ancora inizializzate
vett_zeri:                  .FILL 10, 1, 0          # vettore di byte a 10 componenti inizializzate a zero


.TEXT
_main:                      NOP
                            MOV $0, %EBX

indirizzamenti:             MOV $0, %AL # immediato
                            MOV %AL, %BL # di registro
                            MUL %BL      # di registro

                            PUSH x      # indirizzamento diretto
                            # è come se fosse PUSHB 0x0..4

                            MOV $1, %ESI 
                            MOV vett_b(%ESI), %AL    # indirizzamento indiretto (a registro puntatore)
                            # vett_b(%ESI) = vett_b[i] con i = %ESI
                            # per scorrere il vettore di byte aumentare di 1 esi ogni volta
                            # se fosse stato di word aumnetare di 2 (shift sx)

                            MOV vett_l(,%ESI, 4), %AL # indirizzamento con displacement
                            # (,registro,  fatt. di scala) 
                            # fattore di scala = 1 se byte, = 2 se word, = 4 se long
                            # per scorrere il vettore con questa notazione basta incrementare esi

costanti:                   ADD $8, %BL         # costante decimale
                            ADD $0b1000, %BL    # costante binaria
                            ADD $0x08, %BL      # costante esadecimale
                            MOV $'?', %AL       # codifica ASCII in %AL

vettori:                    MOVB $100, x(%ESI)
                            MOV x(%ESI), %AL        # trasformo x da variabile a vettore con 2 elementi
                            # x = 5 --> x[0] = 5, x[1] = 100

# perchè il programma funzioni commentare da qui in giù per la parte su e viceversa
                            MOV $0, %ESI

stampa:                     LEA mess, %EBX 
                            MOV $6, %CX
                            CALL outmess        # in outline si omette il numero di caratteri in  cx
                                                # però l'ultima codifica ascii deve essere 0x0D (ritorno carrello)
                                                # oppure quando arriva ad un max di 80 caratteri

                            # stampiamo vett_l
                            MOV vett_l(,%ESI, 4), %EAX 
                            CALL outdecimal_long 
                            CALL newline
                            INC %ESI
                            CMP $5, %ESI 
                            JNE stampa

                            CALL sottoprogramma

fine:                       RET 



sottoprogramma:             NOP 

                            PUSH %AX

                            POP %AX 

fine_sottoprogramma:        RET 


