.model small ; Reserve 64kb memory for data and code 

.stack 100h ; Reserve 256 bytes for stack

.data ; Data directive 
 
    message db "                    *******Calculator******* $" 
    userMessage db "      Select any operation from the given functions $"  
    one db "1.Addition   $" 
    two db "2.Subtraction   $" 
    three db "3.Multiplication  $" 
    four db "4.Division  $"
    five db "5.Square  $" 
    six db "6.Cube  $" 
    seven db "7.Square Root$" ; New menu option for square root
    eight db "8.Decimal to binary$" 
    nine db "9.Program Exit$" 
     
    restriction db "Enter your choice$"
    number1 db "Enter the first number: $"  
    number2 db "Enter the second number: $"  
    singleNumberPrompt db "Enter the number: $" ; New message for square/cube/square root
    DeciConverProm db "Enter the number between 0-9: $" 
    resultArray db "Conversion of decimal to binary is: $"
    resultText db "The result is: $"
    exitMessage db "Thank You for using this Application$" ; Exit message 
    
    errorMessage db "Cannot divided by 0! $ "  
    againMesaage db "Enter second number again: $"
    result db ? ; Store result here                  
                                    
    Sumresult db "Result Of Addition is: $"
    Subresult db "Result Of Subtraction is: $"
    Mulresult db "Result Of Multiplication is: $"
    Divresult db "Result Of Division is: $"
    Sqresult db "Result Of Square is: $"
    Cuberesult db "Result Of Cube is: $"
    SQRresult db "Result Of Square Root is: $"                                
                                    
                                  
    array db 4 dup(?)

.code ; Code section

; Macros for operations
Addition macro v1, v2
    mov al, v1
    add al, v2
    mov result, al
endm

Subtraction macro v1, v2
    mov al, v1
    sub al, v2
    mov result, al
endm

Multiplication macro v1, v2
    mov al, v1
    mul v2
    mov result, al ; Only the low byte is used for simplicity
endm

Division macro v1, v2
    mov al, v1
    mov ah, 0 ; Clear AH for division
    div v2
    mov result, al ; Store quotient in result
endm

Square macro v1
    mov al, v1
    mul al ; Multiply AL by itself
    mov result, al ; Store result
endm  

Cube macro v1
    mov al, v1
    mul al ; Multiply AL by itself 
    mul v1 ; Multiply again to get the cube
    mov result, al ; Store result  
endm

SquareRoot macro v1
    ; Approximate square root by testing each possible result value
    mov al, v1
    mov bl, 0       ; Starting test value in BL (potential square root)
SquareRootLoop:
    inc bl          ; Increment potential square root
    mov ah, 0       ; Clear AH to ensure AX has only BL
    mov al, bl
    mul bl          ; Square the test value (result in AX)
    cmp al, v1      ; Check if square is greater than input
    ja EndSquareRoot ; If it is, stop
    jmp SquareRootLoop ; Otherwise, continue 
    
EndSquareRoot:

    dec bl          ; Subtract 1 to get closest integer root
    mov result, bl  ; Store result as approximate square root     
endm  

Binaryconversion macro v1
           mov al,v1  
           mov bl,2  
                      
           mov si,OFFSET array 
           mov cx,4
       conversion_loop:
           mov ah,00     ;Clear AH 
           div bl      
           mov [si],ah 
           inc si  
       loop conversion_loop
       
       mov [si],al 
      
endm
      
      
      
main proc ; Main procedure 
    
    mov ax, @data ; Initialize data segment
    mov ds, ax

Start:  

    ;Display welcome message
    call NewLine 
    call NewLine 
    call NewLine
    
    mov dx, offset message
    call print_String
   
    call NewLine 
    call NewLine

    ; Display menu
    mov dx, offset userMessage    
    call print_String
    
    call NewLine
    call NewLine

    ; Display operations
    mov dx, offset one 
     call print_String
    
    call NewLine

    mov dx, offset two
     call print_String
    call NewLine

    mov dx, offset three
    call print_String
    call NewLine

    mov dx, offset four 
    call print_String
    call NewLine

    mov dx, offset five 
    call print_String
    call NewLine

    mov dx, offset six  
    call print_String
    call NewLine  

    mov dx, offset seven
    call print_String
    call NewLine 
    
    mov dx, offset eight 
    call print_String 
    call NewLine 
    
    mov dx,offset nine
    call print_String 
    call NewLine
    call NewLine

    ; Display exit option
    mov dx, offset restriction 
    call print_String
    call NewLine

    ; Get user operation choice
    mov ah, 1
    int 21h
    sub al, '0' ; Convert ASCII to integer
    mov bl, al ; Store choice in BL 

    cmp bl,9
    je ExitProgram ; Exit if choice is 9

    call NewLine

    ; Determine which prompt to display based on operation
    cmp bl, 5
    je SquareOrCubePrompt
    cmp bl, 6
    je SquareOrCubePrompt
    cmp bl, 7
    je SquareOrCubePrompt
    cmp bl,8
    je DecToBinConversion
                          
    cmp bl,1 
    je FirstNumberLabel
    cmp bl,2 
    je FirstNumberLabel
    cmp bl,3  
    je FirstNumberLabel
    cmp bl,4   
    je FirstNumberLabel
  
    ;jne Start
    FirstNumberLabel:
        ; For other operations, display "Enter the first number"
        mov dx, offset number1
        jmp ShowPrompt
        
    DecToBinConversion:
           mov dx,offset DeciConverProm
           jmp ShowPrompt

SquareOrCubePrompt:

    ; Display "Enter the number" for square, cube, and square root operations
    mov dx, offset singleNumberPrompt

ShowPrompt: 

    call print_String
    
    call GetNumber
    mov cl, al ; Store first number in CL
    call NewLine

    ; If square, cube, or square root, skip second input and go to respective operation
    cmp bl, 5
    je DoSquare
    cmp bl, 6
    je DoCube 
    cmp bl, 7
    je DoSquareRoot 
    
    cmp bl,8
    je DoConversion

    ; Get number 2 for other operations
    mov dx, offset number2 
    call print_String
  
    call GetNumber
    mov ch,al ; Store second number in CH 
    call NewLine

    ; Perform selected operation
    cmp bl, 1
    je DoAddition
    cmp bl, 2
    je DoSubtraction
    cmp bl, 3
    je DoMultiplication
    cmp bl, 4
    je DoDivision
    jmp Start ; Go back to start if invalid option  

DoAddition: 

    Addition cl, ch  
    mov dx, offset Sumresult
    jmp DisplayResult

DoSubtraction: 

    Subtraction cl, ch 
    mov dx, offset Subresult
    jmp DisplayResult

DoMultiplication: 

    Multiplication cl, ch 
    mov dx, offset Mulresult
    jmp DisplayResult

DoDivision:  

    cmp ch, 0 ; Check if dividing by zero
    je Error
    Division cl, ch
    mov dx, offset Divresult
    jmp DisplayResult

DoSquare: 

    Square cl ; Calculate the square of the first number 
    mov dx, offset Sqresult
    jmp DisplayResult
                    
DoCube: 

    Cube cl ; Calculate the cube of the first number 
    mov dx, offset Cuberesult
    jmp DisplayResult

DoSquareRoot:

    SquareRoot cl ; Calculate the square root of the first number  
    mov dx, offset SQRresult
    jmp DisplayResult  
    
DoConversion: 
 
       Binaryconversion cl
       jmp DisplayArray
      

Error: 

    call Newline    
    mov dx,offset errorMessage 
    call print_String
    call NewLine
    
    mov dx, offset againMesaage    
    call print_String
   
    call GetNumber
    mov ch, al ; Store second number in CH 
    call NewLine
                     
    cmp ch,0
    jne DoDivision 
    je Error  
    call NewLine 
        

DisplayResult: 

    call print_String
    
    mov al, result
    add al, '0' ; Convert result to ASCII
    mov dl, al
    mov ah, 2
    int 21h

    call NewLine
    jmp Start ; Loop back to the start for another operation   
    
    
DisplayArray: 

    mov dx,offset resultArray
    call print_String
    
    mov si,Offset array + 3   ;means storing last index in si  
    mov cx,4  

      print_array:
         mov dl,[si]       ;si means index register
         add dl,'0'             ;pass value to dx stored at index si
         mov ah,2
         int 21h
         
         dec si            ;Decrement the address<index register> by 1
      loop print_array 
      jmp Start    
      

ExitProgram: 
 
    call NewLine 
    call NewLine
    
    ; Display exit message   
    mov dx, offset exitMessage
    call print_String

    ; Exit program
    mov ah, 4Ch
    int 21h

main endp


    ; Procedure to get a single-digit number from user
    GetNumber proc
         mov ah, 1
         int 21h
         sub al, '0' ; Convert ASCII to integer
         ret
    GetNumber endp

    ; Procedure for newline
    NewLine proc 
        mov dl, 10
        mov ah, 2
        int 21h

        mov dl, 13
        mov ah, 2
        int 21h
        ret
    NewLine endp    

    print_String proc  
       mov ah, 9
       int 21h
    
       ret
    print_String endp
    

end main ; End of program