;program for multiplcation

.model small
.stack 100h 
.data 
.code 
      main proc
              ;stor 3 in al 
             
        mov ah,'3'    
        mov bh,'5'  ;store 5 in bl;
        
        add bh,ah     ;add bl and al
        
        
        mov cl,'2'   ; store  2 in cl
        sub bh,cl     ;sub clto bl
        mov al,'1'    ;store 1 into al
        sub bh,al 
        
        mov dl,bh   ;move bl into dl
        sub dl, 48     ;sub 48 from dl register
        add dl, 48       ;add 48 from dl register
        add dl, 48         ;add 48 from dl register
        
         mov ah,2
         int 21h
         mov ah,4ch
         int 21h


main endp
end main

