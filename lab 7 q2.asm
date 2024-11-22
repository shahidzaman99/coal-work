.model small
.stack 100h

.data

.code

; Macro to add two numbers and store the result in a third register
ADD_NUMS MACRO num1, num2, result
    mov al, num1        ; Move first number to AL
    sub al, 48          ; Convert from ASCII to integer
    add al, num2        ; Add second number (also in ASCII)
    sub al, 48          ; Convert second number from ASCII to integer
    add al, 48          ; Convert back to ASCII for storing
    mov result, al      ; Store the result in the result variable
ENDM

; Macro to display a character
DISPLAY_CHAR MACRO char
    mov dl, char        ; Move the character to DL
    mov ah, 02h         ; DOS interrupt to display a character
    int 21h
ENDM

main proc

    ; Store values in registers
    mov ah, '1'         ; First number
    mov bh, '2'         ; Second number
    mov ch, '3'         ; Third number
    mov dh, '2'         ; Fourth number

    ; Perform addition using macros
    ADD_NUMS bh, ah, bh ; bh = bh + ah
    ADD_NUMS dh, ch, dh ; dh = dh + ch
    ADD_NUMS dh, bh, dh ; dh = dh + bh

    ; Display the result
    DISPLAY_CHAR dh     ; Display the result in dh

    ; Terminate program
    mov ah, 4ch
    int 21h

main endp

end main
