	
	%INCLUDE "mikedev.inc"
	
	ORG 32768
	
	
	
	 mov si, welcome         ;printing starting messages
     call os_print_string
     call os_print_newline 
     mov si, msg           
     
     call os_print_string 
START:
    mov ax, list
	mov bx, msg1
	mov cx, msg2
	call os_list_dialog       ;taking input
	jc exit 
	
                      
    cmp ax,01h                 ;choosing audio file to play
    je c1
    
    cmp ax,02h
    je c2
    
    cmp ax,03h
    je c3
    
    cmp ax,04h
    je c4
    
    cmp ax,05h
    je c5
    
    cmp ax,06h
    je c6  
	     
	
	 
	c1: mov ax, ch1
	jmp selected  
	
	c2: mov ax, ch2  
	jmp selected   
	
	c3: mov ax, ch3
	jmp selected
	                 
    c4: mov ax, ch4
	jmp selected
	 
	c5: mov ax, ch5
	jmp selected  
	
	c6: mov ax, ch6  
	jmp selected 
   
	selected:  
	
                

;	 mov bx, ax 
    
    
    
    ;mov ax, bx
	mov cx, 36864			; to Load file at  (4K after program start)
	call os_load_file 
	jc notfound     
	
	
	
	   
  mov si, 0                    ;implementing audio player
    L1: 
        mov dx, 388h  
		mov al, [si+music+0]
		call os_port_byte_out 
		mov dx, 389h
		mov al, [si+music+1]
	    call os_port_byte_out
		mov bx, [si+ music +2]
	    add si, 4   

        delay:	           
            mov cx,500 
            l2: loop l2
            dec bx
        jg delay 

 
        cmp si,size
    jb L1 
    jmp START
      
notfound:    
    call os_clear_screen
    mov si,errormsg 
    call os_print_string 
    call os_wait_for_key 
   call os_clear_screen
   jmp START
     
exit:
   call os_clear_screen
    ret
    	   
	        
welcome db'Welcmoe to Sound Player [Batch 1- Group 5]',0
msg db 'You may Select any Audio  fom list (press escape to exit)',0   
errormsg db 'file not found, press any key to continue' ,0
list	db 'test play1,test play2,test play3,test play4,test play5,test play6,', 0
msg1	db 'Choose an option', 0
msg2	db 'Or press Esc to quit', 0    
ch1 db 'test1.imf',0
ch2 db 'test2.imf',0
ch3 db 'test3.imf' ,0 
ch4 db 'test4.imf',0
ch5 db 'test5.imf',0
ch6 db 'file1.imf' ,0  

music dw 36864
size dw 9999
