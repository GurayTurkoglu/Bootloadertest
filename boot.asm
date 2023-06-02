ORG 0x7C00
boot:
    jmp main
main:
MOV AH, 0
MOV AL, 12h
INT 10h


;JMP sutun

;sutun:
;INC CX
;CMP CX, 320
;INT 10h
;JNE sutun
;INC dx
;CMP dx, 200
;INT 10h
;JNE sutun

;MOV AH, 06h
;MOV AL, 00h
;MOV BH, 1
;MOV CH, 00
;MOV CL, 00
;MOV DH, 30
;MOV DL, 80
;INT 10h

JMP devam

devam:
push 0x4B01
pop si

MOV DL, 0x41
MOV DH, 0xF
ADC DH,DL
MOV [si], DH
LODSB ;si registerinden aldigi adresin icindeki degeri AL registerine yazar

;MOV DL, 
;MOV AL, [esi]
;MOV AH, 02h
;MOV BH, 0
;MOV DH, 2
;MOV DL, 5
;INT 10h

;MOV AH, 09h
;MOV BH, 0
;MOV BL, 1111b
;MOV CX, 11
;INT 10h 
JMP dongu

dongu:
MOV AH, 01h
MOV DL, 00h
INT 13h
MOV AL, AH
CMP AL, 0x0
JE succ
JNE testdrive

succ:
MOV AH, 01h
MOV BH, 0x0
MOV BL, 1110b
MOV CX, 43
MOV DH, 1
MOV DL, 1
MOV BP, mesajsucc
MOV AH, 13h
INT 10h

testdrive:
CMP AL, 01h
JE invalidcomm
JNE devam1111

invalidcomm:
MOV AH, 01h
MOV BH, 0x0
MOV BL, 1100b
MOV CX, 40
MOV DH, 1
MOV DL, 1
MOV BP, mesajinvalid
MOV AH, 13h
INT 10h
JMP invalidcomm

devam1111:
MOV AL, 0h
JMP devam2222

devam2222:
MOV CX, 0Fh
MOV DX, 4240h
MOV AH, 86h
INT 15h

INC AL
CMP AL, 3
JE devam3333
JNE devam2222

devam3333:
MOV AL, 0h
MOV BH, 0000b
MOV CH,	0
MOV CL, 0
MOV DH, 30
MOV DL, 80
MOV AH, 07H
INT 10h

MOV AL, 01h
MOV BH, 0
MOV BL, 1110b
MOV CX, 0x19
MOV DH, 1
MOV DL, 28
MOV BP, msg1
MOV AH, 13h
INT 10h

;MOV AH, 02h
;INC DL
;INT 10h

;MOV AH, 09h
;MOV BL, 1111b
;INC AL
;INT 10h
;CMP DL, 20
;JNE dongu

MOV CL, 0x1
MOV DH, 3
JE son3

son3:
MOV AH, 00h
INT 16h
CMP CL, 0
JE DUZELTME

MOV DL, AL
CMP AL, 13
JE ENTERKOMUT
JNE kontrol

DUZELTME:
INC CL
JMP son3

ENTERKOMUT:
INC DH
MOV CL, 0x0
MOV AH, 02h
MOV BH, 0
MOV DL, CL
INT 10h
JMP kontrol

kontrol:
CMP AL, 0x08
JE SILMEKOMUT
JNE DVM

SILMEKOMUT:
MOV AH, 02h
MOV DL, CL
MOV BH, 0
INT 10h	

MOV AH, 0Eh
MOV AL, 00
MOV BH, 0
MOV BL, 1111b
INT 10h
DEC CL
MOV AL, DL 
JMP son3

DVM:
INC CL
CMP CL, 78
JNE DEVAM
JE SUTUNARTTIR

SUTUNARTTIR:
INC DH
MOV CL,0x2
JMP DEVAM

DEVAM:
MOV AH, 02h
MOV DL, CL
MOV BH, 0
INT 10h	

MOV AH, 0Eh
MOV BH, 0
MOV BL, 1111b
INT 10h


JMP son3
mesajsucc: db "TEST: BASARILI SURUCU TESTI -- SISTEM DEVAM"
mesajinvalid: db "TEST: BASARISIZ TEST -- SISTEM HALT"
msg1: db "TEST MBR BOOTLOADER",00
times 510-($-$$) db 0 
dw 0xAA55      
