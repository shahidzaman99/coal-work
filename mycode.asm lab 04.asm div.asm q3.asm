.model small
.stack 100h
.data 
    
  msg dw "The average of numbers : $";
  var1 db 3
  var2 db 4
  var3 db 5 


.code

    main proc   
        
    mov ax, @Data;   ; import data
    
    mov ds,ax; 
    
    LEA cx,msg;      ; loop for printing msg
    mov ah,9;
    int 21h
    
        
    mov al,var1;    ; mov var1 to al
    add al,var2     ; add directly var2 to al
    add al,var3;    ; add directly var3 to al
    add al,var1;    ; add directly var1 to al 
    add al,var3;    ; add directly var3 to al  
                      
    mov dl,al;      ; store value of dl to al
    mov ah,00;
    
    mov bl,5; 
    
    div bl;   
         
    add al,30h;  
    mov dl,al;
    
    mov ah,2;
    int 21h    
    
    main endp

end main

