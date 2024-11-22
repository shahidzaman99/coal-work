
                                                                     .model small
.stack 100h

.data
var1 db ?                ; Optional variable, not used in this code
var2 db 5                ; Optional variable, not used in this code
var3 db "abcdefg$"       ; String to be displayed

.code

; Macro to display a string
DISPLAY_STRING MACRO str
    mov dx, offset str  ; Move the effective address of str into DX
    mov ah, 09h         ; DOS function to display a string
    int 21h             ; Call DOS interrupt
ENDM

main proc
    mov ax, @data       ; Get the reference of data section
    mov ds, ax          ; Pass it to the ds register

    ; Display the string stored in var3
    DISPLAY_STRING var3  ; Display the string using the address of var3

    ; Terminate program
    mov ah, 4ch
    int 21h
main endp

end main
