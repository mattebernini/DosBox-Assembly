# legge da terminale messaggio in lettere
# stampa messaggio tutto maiuscolo

.GLOBAL _main
.INCLUDE "C:/amb_GAS/utility" 

.DATA
msg_in:         .FILL 80, 1, 0  # numero, dim, valore
msg_out:         .FILL 80, 1, 0

.TEXT
_main:          NOP
                # leggo da terminale
                MOV $80, %CX
                LEA msg_in, %EBX        # mettere in EBX l'indirizzo della stringa su cui salvare l'input
                CALL inline

                LEA msg_in, %ESI
                LEA msg_out, %EDI

inizio:         MOV (%ESI), %AL         # do{
                                        # al = *esi
                # elaborazione
# differenze tra maiuscole e minuscole è il bit numero 5
# maiuscole 0x41 fino 0x54, minuscole 0x61 fino 0x7A in ASCII
                CMP $0x61, %AL          # AL contiene i singoli char
                JB poi
                CMP $0x7A, %AL
                JA poi
# controllato se devo trasformare il char ( se il char è minuscolo )
# lo trasformo con una maschera di bit, metto il 5° bit a zero
# la maschera è tutti i bit a 1 e il 5° a 0, si usa un AND
                AND $0xDF, %AL


poi:            MOV %AL, (%EDI)

                INC %ESI    # (caratteri sono su un byte)
                INC %EDI 

                CMP $0x0D, %AL          # 0x0D carattere fine stringa
                JNE inizio

fine:           LEA msg_out, %EBX
                CALL outline
                RET


