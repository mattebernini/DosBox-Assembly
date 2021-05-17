/*
    Scrivere un programma Assembler che si comporta come segue:
    1. Chiede in ingresso un numero INTERO x in base 10, 
       rappresentato in modulo e segno, supponendo che il modulo stia su 8 bit
    2. aggiunge il numero x digitato, ad un accumulatore s, che sta su *10 bit*
       (1 bit di segno e 9 di modulo). s è¨ inizialmente pari a zero.
       Se l'operazione di somma algebrica ritorna un numero non rappresentabile
       su 10 bit in modulo e segno, stampa "overflow" e termina. 
       Altrimenti stampa s in modulo e segno.
     Esempio:
     ?+255
     +255
     ?-20
     +235
     ?+255
     +490
     ?+255
     overflow
*/ 

.GLOBAL _main
.INCLUDE "c:/amb_GAS/utility"

.DATA
msg:        .ASCII "overflow"

.TEXT
_main:
        NOP
        MOV $0, %BX     # s sta in BX, 7 bit vuoti, 9 di modulo
        MOV $'+', %CH   # segno di s sta in CH
inizio:
        MOV $'?', %AL
        CALL outchar
        MOV $0, %AX
input_s:
        CALL inchar
        CMP $'-', %AL
        JNE seconda_cond
        JMP input_mod
seconda_cond:
        CMP $'+', %AL
        JNE input_s
input_mod:
        CALL outchar
        MOV %AL, %CL    # segno sta in CL
        CALL indecimal_byte 
        CALL newline
        # s è un intero b=2, n=10, [-512; 511]
        CMP %CH, %CL
        JE concordi
discordi:
        CMP $'-', %CH 
        JE x_meno_s
        SUB %AX, %BX
        CMP $0, %BX
        JG rappr
        MOV $'-', %CH
        JMP rappr
x_meno_s:
        SUB %BX, %AX
        MOV %AX, %BX
        CMP $0, %BX
        JL rappr
        MOV $'+', %CH
        JMP rappr
concordi:
        ADD %AX, %BX
rappr:
        CMP $511, %BX
        JBE stampa
        CMP $512, %BX
        JA ow 
        CMP $'+', %CH
        JE ow
stampa:
        MOV %CH, %AL
        CALL outchar
        MOV %BX, %AX
        CALL outdecimal_word
        CALL newline
        JMP inizio
ow:
        PUSH %EBX
        PUSH %ECX
        LEA msg, %EBX
        MOV $8, %CX
        CALL outmess
        POP %ECX
        POP %EBX
fine:
        RET



        