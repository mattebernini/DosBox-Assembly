.GLOBAL _main

.INCLUDE "c:/amb_GAS/utility"

.DATA
stringaSource:   .FILL 10, 1
stringaDest:     .FILL 10, 1
array1:          .BYTE 1, 2, 3, 4, 5, 6, 7 
array2:          .BYTE 1, 2, 3, 18, 5, 6, 7 

.TEXT
_main:
            NOP
            # store string
            MOV $18, %AL
            LEA stringaSource, %EDI
            MOV $10, %ECX
            CLD
            REP STOSB                                                 
            # move data from string to string
            CLD                                 # clear direction flag
            LEA stringaSource, %ESI
            LEA stringaDest, %EDI 
            MOV $10, %ECX
            REP MOVSB                   # MOVS-suffisso 

            CLD
            LEA stringaDest, %ESI 
            MOV $10, %ECX
            LODSB
            CALL outdecimal_byte    # stampa 18

            CLD
            LEA array1, %ESI
            LEA array2, %EDI 
            MOV $7, %ECX
            REPE CMPSB

            CALL newline
            MOV %ESI, %EAX
            CALL outdecimal_long
            CALL newline
            MOV %EDI, %EAX
            CALL outdecimal_long
            # edi = esi + 7

fine:
            RET

