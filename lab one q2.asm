.model small 

.stack 100h  

.data        

v1 db 3      

v2 db 4      

v3 db ?       

msg db "multiplication of 3 and 4 = $"

.code        ;code section
  
    main proc     ;start of main procedure
    
    mov ax,@data  ;initailize the data segment
    mov ds,ax     ;set ds to point the data segment  
    
    lea dx, msg     ; load address of msg
    mov ah,09h      ; function to display string
    int 21h         ; dos interrupt
    
    mov al,v1     ;store variable v1 in al
    mov bl,v2     ;store variable v2 in bl
    mul bl        ;multiplying variable v1 and v2 
    mov v3,al      
    add al,30h
    mov dl,al     
    mov ah,02h    
    int 21h  