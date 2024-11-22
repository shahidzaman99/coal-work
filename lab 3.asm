.model small
.stack 100h
.data

;var1 db  ?
;var2 db  5
var3  db  "abcdefg$"

.code

   main proc
   
   mov ax,@data  ;get the ref of data section
   mov ds, ax    ;and pass it to ds register


   ;LEA -> load efftive sddress, offset
   
   LED dl, var3  ;get first character of variable

   
   mov ah,9 ; display string on screen 
   int 21 h