;first program add tow number
.model small      ;reserve memory for whole program
.stack 100h       ;reserve memory for stack
.data                                
.code
  main proc       ;main orocedure
                  ;store value in AL
        
  mov ah,'1' 
           
  mov bh,'2'                ;store value in BL   
            
  mov ch,'3'
  
  mov dh,'2'
                  ; add two number and store the result in BL
                
  add bh,ah
  add dh,ch
  add dh,bh  
  
  mov dl,dh
  sub dl,48 
  sub dl,48 
  sub dl,48  
                  ;display program on the screen
  mov ah,2
  int 21h              
  mov ah, 4ch     ;exit program
  int 21h
            
        main endp
            
  end main        ;end program