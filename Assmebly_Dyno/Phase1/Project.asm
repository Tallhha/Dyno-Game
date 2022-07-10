;---------------  GROUP MEMBERS ( NAMES AND ROLL NUMBERS ) 
;--------------   TALHA MUSTAFA ( 18i-0573 )
;--------------   HANZALA AHMED KHAN ( 18i-0518 )

.model small
.stack 100h

.data
;------------ STRINGS TO PRINT
MENU DB "  T-REX GAME /     MENU ,    > PLAY  /> INSTRUCTIONS  /    > EXIT  $"
BACK DB "> BACK$"
SCORE DB "LIVES : 03 ,SCORE     : 00 /HIGHSCORE : 00 $"

;------------ TO STORE CO-ORDINATES TO PRINT STRINGS
CHARROW db ?    
CHARCOL db ?    

;------------ TO STORE MOUSE CLICK CO-ORDINATES
MouseCol db ?
MouseRow db ?

;------------ STORING SCREEN NUMBER AND DIFFERENT COLORS
Screen db ?
color db ?

;------------ CO-ORDINATES OF T-REX TO DRAW
DynoRow   dw 157,155,153,151,149,151,149,147,147,145,143,141,139,137,137,135,133,131,129,127,125,123,121,119,117,115,0
DStartCol dw 50,47,44,44,47,25,22,19,32,37,40,43,46,49,74,52,55,58,61,64,67,67,67,67,70,73,0
DEndCol   dw 60,57,54,57,60,38,42,24,60,63,66,69,69,69,80,83,83,78,75,75,78,86,89,89,85,82,0

drow dw ?
dstart dw ?
dend dw ?

;------------ CO-ORDINATES OF HURDLES TO DRAW
HurdleRow dw 157,154,151,148,145,142,1,
			163,160,157,154,151,148,145,142,140,151,148,145,143,151,148,145,142,139,2,
			100,98,96,94,92,90,88,86,92,89,86,83,80,0
			
HStartCol dw 120,120,105,110,115,120,1,
			200,200,200,200,200,200,200,200,201,205,208,208,210,195,192,190,190,192,2,
			230,225,215,205,210,215,220,225,240,240,240,240,240,0
			
HEndCol   dw 130,130,145,140,135,130,1,
			205,205,205,205,205,205,205,205,204,210,212,212,212,200,195,195,195,195,2,
			260,270,265,275,240,235,233,230,260,256,252,248,244,0

hrow dw ?
hstart dw ?
hend dw ?

;------------ CO-ODRINATES OF CLOUDS TO DRAW
CloudRow dw 50,48,45,43,43,45,41,39,37,39,41,50,48,46,43,41,43,39,52,54,
			 50,48,45,43,43,45,41,39,37,39,41,50,48,46,43,41,43,39,52,54,0
			
CStartCol dw 50,71,87,77,70,67,67,67,60,65,65,40,42,44,44,47,58,58,42,47,
			 190,211,227,217,210,207,207,207,200,205,205,180,182,184,184,187,198,198,182,187,0
			 
CEndCol   dw 70,90,90,88,72,70,76,74,72,69,67,42,44,46,46,58,60,60,46,49,
			 210,230,230,228,212,210,216,214,212,209,207,182,184,186,186,198,200,200,186,189,0

crow dw ?
cstart dw ?
cend dw ?

;------------ CO-ODRINATES OF SUN AND DUST TO DRAW
ObjectRow dw 164,164,164,166,166,169,172,175,178,171,167,174,177,167,172,169,175,172,179,176,1,
			 32,35,38,41,44,47,50,53,56,59,62,65,68,0	

OStartCol dw 206,209,212,198,201,110,150,30,90,250,190,290,150,280,170,40,63,273,210,243,1,
			 284,286,288,290,292,294,297,300,303,306,309,312,315,0

OEndCol   dw 207,210,213,199,202,112,152,37,92,258,192,292,157,282,173,42,65,275,218,245,1,
			 319,319,319,319,319,319,319,319,319,319,319,319,319,0

orow dw ?
ostart dw ?
oend dw ?

;------------ FOR FILE READING
file db 'myfile.txt',0
buffer db 100 DUP('$')

.code
Main Proc

mov ax,@data
mov ds,ax

Beginning:
;-------- VIDEO MODE

MOV AH,0
MOV AL,13h
INT 10h

mov Screen,0

;------- DRAWING A LINE USING PIXELS
mov bx,0
mov si,160

repeat 3

	repeat 320
		mov ah,0Ch
		mov al,00001111b
		mov cx,bx
		mov dx,si
		int 10h

		inc bx
	endm

	mov bx,0
	inc si
endm

;------- DRAWING DYNO
mov color,00000010b
Call Dyno


;------- DRAWING MENU
mov CHARROW,1
mov CHARCOL,10
mov si,0
PrintPlay:	
	;Moving Cursor To Print Charecter	
	mov  dh, CHARROW    
	mov  dl, CHARCOL    
	mov  bh, 0          
	mov  ah, 02h        
	int  10h

	;Printing Charecter
	mov ah,09h
	mov  al, MENU[si]   
	
	.if(al==',')
		mov CHARCOL,10
		mov CHARROW,8
		inc si
		jmp PrintPlay
	.elseif(al=='/')
		add CHARROW,2
		mov CHARCOL,10
		inc si
		jmp PrintPlay
	.elseif(al=='$')	
		jmp mousecheck
	.else
		mov  bh, 0          
		mov bl, 00000100b   
		mov cx,1             
		int  10h
			
		inc si
		add CHARCOL,1
		jmp PrintPlay
	.endif
	
mousecheck:

	mov bl,0
;-----SetMouse
	mov ax,1
	int 33h
;-----Get Mouse row/col on click	
	mov ax,3
	int 33h
	
	push bx
	
	mov bh,0
	mov bl,8
	mov ax,dx
	div bl
			
	mov MouseRow,al
		
	mov ax,cx
	div bl
			
	mov MouseCol,al
	
	pop bx
	cmp bl,1
	jne mousecheck
	je compare
	
compare:	
;--------- CLICK CHECK CONDITIONS
		.if(MouseRow == 8 && MouseCol>=32 && MouseCol<=38 && Screen==0)
			jmp PlayScreen
		.elseif(MouseRow == 10 && MouseCol>=23 && MouseCol<=46 && Screen==0)
			jmp InstructionScreen
		.elseif(MouseRow == 12 && MouseCol>=32 && MouseCol<=38 && Screen==0)
			jmp ExitScreen
		.elseif(MouseRow == 20 && MouseCol>=62 && MouseCol<=67 && Screen==1)
			jmp Beginning
		.else
			jmp mousecheck
		.endif
		
PlayScreen:

;-------------- SCREEN FOR DISPLAYING GAME
mov ax,2
int 33h

MOV AH,0
MOV AL,13h
INT 10h
	
Call Background

mov CHARROW,1
mov CHARCOL,1
mov Screen,2
mov si,0
PrintScore:			
	;Moving Cursor To Print Charecter	
	mov  dh, CHARROW    
	mov  dl, CHARCOL    
	mov  bh, 0          
	mov  ah, 02h        
	int  10h
	
	;Printing Charecter
	mov ah,09h
	mov  al, SCORE[si]  
	.if(al==',')
		mov CHARCOL,65
		inc si
		jmp PrintScore
	.elseif(al=='/')
		add CHARROW,1
		mov CHARCOL,65
		inc si
		jmp PrintScore
	.elseif(al=='$')
		jmp continue4
	.else
		mov  bh, 0          
		mov bl, 00000100b   
		mov cx,1           
		int  10h
			
		inc si
		add CHARCOL,1
	
		jmp PrintScore
	.endif

continue4:

;------- DRAWING A LINE USING PIXELS
mov bx,0
mov si,160
repeat 3

	repeat 320
		mov ah,0Ch
		mov al,00000000b
		mov cx,bx
		mov dx,si
		int 10h

		inc bx
	endm

	mov bx,0
	inc si
endm

;------ DRAWING DYNO
mov color,00000010b
CALL Dyno
;------ DRAWING HURDLES
mov color,00000000b
CALL Hurdles
;------ DRAWING CLOUDS
mov color,00001111b
CALL Clouds
;------ DRAWING OTHER OBJECTS
mov color,00000000b
CALL Objects

jmp endprog

InstructionScreen:

;----------- READING AND DISPLAYING INSTRUCTIONS FROM FILE

MOV AH,0
MOV AL,13h
INT 10h

mov Screen,1

;----- LOADING IN READ MODE
mov cx,100
mov dx, offset file                 
mov al, 0                           
mov ah, 3Dh                          
int 21h  

;----- STORING DATA IN STRING
mov bx, ax                
mov dx, offset buffer                 
mov ah, 3Fh 
int 21h    

mov si,0
mov CHARROW,5
mov CHARCOL,3
PrintInst:
	;Moving Cursor To Print Charecter	
	mov  dh, CHARROW    
	mov  dl, CHARCOL    
	mov  bh, 0          
	mov  ah, 02h        
	int  10h

	;Printing Charecter
	mov ah,09h
	mov  al, buffer[si] 
	
	.if(al==13)
		add CHARROW,1
		mov CHARCOL,3
		add si,2
		jmp PrintInst
	.elseIf(al=='$')
		jmp continue2
	.else			
		mov  bh, 0    
		mov bl, 00001111b 
		mov cx,1           
		int  10h
			
		inc si
		add CHARCOL, 1
	
		jmp PrintInst
	.endif

continue2:

;----- CLOSING FILE
mov ah, 3Eh 
int 21h       
  
mov si,0
mov CHARROW,20
mov CHARCOL,70
PrintBack:
	;Moving Cursor To Print Charecter	
	mov  dh, CHARROW    
	mov  dl, CHARCOL    
	mov  bh, 0          
	mov  ah, 02h        
	int  10h

	;Printing Charecter
	mov ah,09h
	mov  al, BACK[si]  
	.If(al=='$')
		jmp continue3
	.else	
		mov  bh, 0     
		mov bl, 00000001b  
		mov cx,1             
		int  10h
			
		inc si
		add CHARCOL, 1
		jmp PrintBack 
	.endif

continue3:

jmp mousecheck
jmp endprog

ExitScreen:

;------ EXITS VIDEO MODE
CALL QUIT
jmp endprog		

endprog:

;------- END
mov ah,4ch
int 21h

main endp

;-------- DYNOOO DRAWING
Dyno Proc

mov si,0
DynoPrint1:

mov bx,DynoRow[si]
mov drow,bx

mov bx,DStartCol[si]
mov dstart,bx

mov bx,DEndCol[si]
mov dend,bx

DynoPrint2:

repeat 3
	mov ah,0Ch
	mov al,color
	mov cx,dstart
	mov dx,drow
	int 10h

	inc drow
endm

.if(dstart==0)

	mov drow,117
	mov dstart,75

repeat 2
	
	repeat 2
	
	mov ah,0Ch
	mov al,00000000b
	mov cx,dstart
	mov dx,drow
	int 10h

	inc dstart
	endm
	
	inc drow
	mov dstart,75	
	endm
	
	ret

.elseif(dstart<bx)
	inc dstart
	sub drow,3
	jmp DynoPrint2

.elseif(dstart==bx)
	add si,2
	jmp DynoPrint1

.endif


Dyno endp

;------- DRAWING HURDLES
Hurdles Proc

mov si,0
HurdlePrint1:

mov bx,HurdleRow[si]
mov hrow,bx

mov bx,HStartCol[si]
mov hstart,bx

mov bx,HEndCol[si]
mov hend,bx

HurdlePrint2:

repeat 3
	mov ah,0Ch
	mov al,color
	mov cx,hstart
	mov dx,hrow
	int 10h

	inc hrow
endm

.if(hstart==0)

	mov hrow,88
	mov hstart,227

repeat 2
	
	repeat 2
	
	mov ah,0Ch
	mov al,00001111b
	mov cx,hstart
	mov dx,hrow
	int 10h

	inc hstart
	endm
	
	inc hrow
	mov hstart,227	
	endm

	ret
	
.elseif(hstart==1)
	mov color,00000010b
	add si,2
	jmp HurdlePrint1
.elseif(hstart==2)
	mov color,00000100b
	add si,2
	jmp HurdlePrint1	
.elseif(hstart<bx)
	inc hstart
	sub hrow,3
	jmp HurdlePrint2
.elseif(hstart==bx)
	add si,2
	jmp HurdlePrint1

.endif

Hurdles endp

;-------- DRAWING CLOUDS
Clouds Proc

mov si,0
CloudPrint1:

mov bx,CloudRow[si]
mov crow,bx

mov bx,CStartCol[si]
mov cstart,bx

mov bx,CEndCol[si]
mov cend,bx

CloudPrint2:

repeat 3
	mov ah,0Ch
	mov al,color
	mov cx,cstart
	mov dx,crow
	int 10h

	inc crow
endm

.if(cstart==0)

	ret

.elseif(cstart<bx)
	inc cstart
	sub crow,3
	jmp CloudPrint2
.elseif(cstart==bx)
	add si,2
	jmp CloudPrint1
.endif

Clouds endp

;-------- DRAWING OTHER OBJECTS
Objects Proc

mov si,0
ObjectPrint1:

mov bx,ObjectRow[si]
mov orow,bx

mov bx,OStartCol[si]
mov ostart,bx

mov bx,OEndCol[si]
mov oend,bx

ObjectPrint2:

repeat 3
	mov ah,0Ch
	mov al,color
	mov cx,ostart
	mov dx,orow
	int 10h

	inc orow
endm

.if(ostart==0)
	ret

.elseif(ostart==1)
	mov color,00001110b
	add si,2
	jmp ObjectPrint1
.elseif(ostart<bx)
	inc ostart
	sub orow,3
	jmp ObjectPrint2

.elseif(ostart==bx)
	add si,2
	jmp ObjectPrint1
.endif

Objects endp

;------- DRAWING BACKGROUND OF PLAY SCREEN
Background Proc


mov ah, 07h
mov al, 18 
mov bh, 00001011b 
mov ch, 4  
mov cl, 0  
mov dh, 25 
mov dl, 40 
int 10h

mov ah, 07h
mov al, 5 
mov bh, 00000110b 
mov ch, 20  
mov cl, 0  
mov dh, 40 
mov dl, 40 
int 10h

ret

Background endp

;----- TO EXIT VIDEO MODE
QUIT proc  

 MOV AL, 03   
 MOV AH, 0   
 INT 10H  
 ret
 
QUIT endp 

end main
