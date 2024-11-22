.model small  
.stack 100h   

.data         

msg1 db 'after swap: $' 

var1 db 8  
var2 db 6  

.code     

DISPLAY_CHAR MACRO char
    add char, 30h   ; Convert to ASCII
    mov dl, char    ; Move the character to DL
    mov ah, 02h     ; DOS interrupt to display a character
    int 21h
ENDM

SWAP MACRO v1, v2
    mov al, v1      ; Store v1 in AL
    mov bl, v2      ; Store v2 in BL
    mov v1, bl      ; Swap the values
    mov v2, al
ENDM

main proc 

    mov ax, @data  
    mov ds, ax      

    ; Display message "after swap: "
    lea dx, msg1   
    mov ah, 09h      
    int 21h         

    ; Display var1 and var2 before swap
    DISPLAY_CHAR var1
    DISPLAY_CHAR var2

    ; Swapping var1 and var2
    SWAP var1, var2

    ; Display var1 and var2 after swap
    DISPLAY_CHAR var1
    DISPLAY_CHAR var2

    ; Terminate program
    mov ah, 4ch     
    int 21h
                   
main endp 

end main
