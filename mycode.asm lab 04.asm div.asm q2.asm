

.model small
.stack 100h 
.data 

var1 db 4 
var2 db 5
var3 db 6
.code 
      main proc 
   mov ax,@data  ;get the ref of data section
   mov ds, ax 
   
   
          mov al,var1    ;store var1 in al
         
          mov bl,var2    ;store var2 in bl
          
          mov cl,var3    ;store var3 in cl
          
          
          add al,bl      ;add and storebval
          add cl,al
         
          
          mov dl,cl
         
              
           mov ah,2
           int 21h
           
         

main endp
end main

