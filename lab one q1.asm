.model small  

.stack 100h   

.data         

msg1 db 'after swap: $' 

var1 db 8  
var2 db 6  


.code     

main proc 

    mov ax,@data  
    mov ds,ax      

    
    lea dx, msg1   
    mov ah,09h      
    int 21h         

    
    mov al, var1   
    add al, 30h   
    mov dl, al      
    mov ah, 02h     
    int 21h         

    
    mov al, var2   
    add al, 30h     
    mov dl, al      
    mov ah, 02h     
    int 21h         

    ; swapping var1 and var2
    
    mov al, var1   
    mov bl, var2    
    mov var1, bl    
    mov var2, al        
 
   
    mov al, var1    
    add al, 30h 
    mov dl, al      
    mov ah, 02h     
    int 21h        
    
    mov al, var2  
    add al, 30h    
    mov dl, al     
    mov ah, 02h     
    int 21h         

    
    mov ah,4ch     
    int 21h
                   
main endp 

end main