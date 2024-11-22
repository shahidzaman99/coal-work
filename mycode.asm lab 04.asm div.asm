;program for multiplcation

.model small
.stack 100h 
.data 
.code 
      main proc
        
        mov al,8    ;3*3     one number must be store in ac
        mov bl,3
        
        div bl      ;;mul ax,bl


main endp
end main

