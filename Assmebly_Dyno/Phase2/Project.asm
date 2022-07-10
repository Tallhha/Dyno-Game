;--------------   GROUP MEMBERS ( NAMES AND ROLL NUMBERS ) 
;--------------   TALHA MUSTAFA ( 18i-0573 )
;--------------   HANZALA AHMED KHAN ( 18i-0518 )

.model small
.stack 100h

.data
;------------ STRINGS TO PRINT
MENU DB "  T-REX GAME /     MENU ,    > PLAY  /> INSTRUCTIONS  /    > EXIT  $"
BACK DB "> BACK $"
SCORE DB " ,SCORE    : /HIGHSCORE:9999$"
PNAME DB "ENTER PLAYER NAME: $"
PLAYER DB 20 DUP('$')
HIT DB "COLLISION! (LIVES--)$"
PLUS DB "HEART! (LIVES++)$"
RESTART DB "   GAME OVER! / YOUR SOCRE: //  HIGHSCORES: /TALHA    - 9999/HANZALA  - 8888/PLAYER_X - 6666$"

;------------ TO STORE CO-ORDINATES TO PRINT STRINGS
CHARROW db ?
CHARCOL db ?

;------------ TO STORE MOUSE CLICK CO-ORDINATES
MouseCol db ?
MouseRow db ?

;------------ STORING SCREEN NUMBER, DIFFERENT COLORS, LIVES AND SCORE
Screen db ?
color db ?
KeyCheck db ?
points dw ?
bgcolor db 00001011b
suncolor db 00001110b
bgcount dw 0
lives dW 5

;------------ SCORE CONVERSION
one db ?
two db ?
three db ?
four db ?
str1 db 10 DUP('$')

;------------ CO-ORDINATES OF T-REX TO DRAW
DynoRow   dw 157,155,153,151,149,145,147,145,143,141,139,137,137,135,133,131,129,127,125,123,121,119,117,115,0
DStartCol dw 70,67,64,64,67,49,52,57,60,63,66,69,94,72,75,78,81,84,87,87,87,87,90,93,0
DEndCol   dw 80,77,74,77,80,54,80,83,86,89,89,89,100,103,103,98,95,95,98,106,109,109,105,102,0

drow dw ?
dstart dw ?
dend dw ?

;------------ CO-ORDINATES OF BIRD TO DRAW
BirdRow dw 100,98,96,94,92,90,88,86,92,89,86,83,80,0
BStartCol dw 260,255,245,235,240,245,250,255,270,270,270,270,270,0
BEndCol   dw 290,300,295,305,270,265,263,260,290,286,282,278,274,0

brow dw ?
bstart dw ?
bend dw ?

;------------ CO-ORDINATES OF STONE TO DRAW
StoneRow  dw 157,155,153,151,149,147,145,155,153,151,149,147,145,143,153,151,147,147,0
SStartCol dw 280,278,278,278,278,278,278,290,290,290,290,290,290,280,284,282,282,286,0
SEndCol   dw 290,280,280,280,280,280,280,292,292,292,292,292,292,290,286,288,284,288,0

srow dw ?
sstart dw ?
send dw ?

;------------ CO-ORDINATES OF CACTUS TO DRAW
PlantRow dw 163,160,157,154,151,148,145,142,140,151,148,145,143,151,148,145,142,139,0
PStartCol dw 280,280,280,280,280,280,280,280,281,285,288,288,290,275,272,270,270,272,0
PEndCol   dw 285,285,285,285,285,285,285,285,284,290,292,292,292,280,275,275,275,275,0

prow dw ?
pstart dw ?
pend dw ?

;------------ CO-ODRINATES OF CLOUDS TO DRAW
CloudRow  dw 50,48,45,43,43,45,41,39,37,39,41,50,48,46,43,41,43,39,52,54,
			 50,48,45,43,43,45,41,39,37,39,41,50,48,46,43,41,43,39,52,54,0
			
CStartCol dw 50,71,87,77,70,67,67,67,60,65,65,40,42,44,44,47,58,58,42,47,
			 190,211,227,217,210,207,207,207,200,205,205,180,182,184,184,187,198,198,182,187,0
			 
CEndCol   dw 70,90,90,88,72,70,76,74,72,69,67,42,44,46,46,58,60,60,46,49,
			 210,230,230,228,212,210,216,214,212,209,207,182,184,186,186,198,200,200,186,189,0

crow dw ?
cstart dw ?
cend dw ?

;------------ CO-ODRINATES OF SUN TO DRAW
SunRow1		dw 32,35,38,41,44,47,50,53,56,59,62,65,68,0	
SunStartCol dw 284,286,288,290,292,294,297,300,303,306,309,312,315,0
SunEndCol   dw 319,319,319,319,319,319,319,319,319,319,319,319,319,0

sunrow dw ?
sunstart dw ?
sunend dw ?

;------------ CO-ODRINATES OF DUST TO DRAW
ObjectRow dw 168,164,166,166,169,172,175,178,171,167,174,177,167,172,169,175,172,179,176,171,177,169,169,170,179,171,0	
OStartCol dw 209,212,198,201,110,150,30,90,250,190,290,150,280,170,40,63,273,210,243,30,24,18,19,10,6,3,0
OEndCol   dw 210,213,199,202,112,152,37,92,258,192,292,157,282,173,42,65,275,218,245,31,26,19,20,11,8,5,0

orow dw ?
ostart dw ?
oend dw ?

;--------------  CO-ODRINATES OF EXTRA LIFE TO DRAW
ExtraRow  dw 155,153,151,149,147,145,145,0
EStartCol dw 290,288,286,284,284,286,293,0
EEndCol   dw 292,294,296,298,298,289,296,0

erow dw ?
estart dw ?
eend dw ?
 
;------------- FOR MOVEMENT

;------------- HURDLES MOVEMENT
hurstart dw 0
hurend dw 0
hurrow dw 0

hur1start dw 0
hur1end dw 0
hur1row dw 0

hur2start dw 0
hur2end dw 0
hur2row dw 0

;------------- CLOUD,SAND,DYNO and LIFE MOVEMENT
qstart dw 0
qend dw 0
qrow dw 0

objstart dw 0
objend dw 0
objrow dw 0

jstart dw 0
jend dw 0
jrow dw 0

liferow dw 0
lifestart dw 0
lifeend dw 0

;------------- COUNTERS
break dw ?
jumpcheck db 0
bool db 0      
bool2 db 1
speed dw 9000H

cfix db 0
ofix db 0
fix db 0
chkFIX db 0

birdcheck dw 0
plantcheck dw 0
stonecheck dw 0
lifecheck dw 0

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
	mov color,00001111b
	Call DrawLine
;------- DRAWING DYNO AND HURDLE
	Call Dyno
	Call MoveStone
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
			call PlayScreen
		.elseif(MouseRow == 10 && MouseCol>=23 && MouseCol<=46 && Screen==0)
			jmp InstructionScreen
		.elseif(MouseRow == 12 && MouseCol>=32 && MouseCol<=38 && Screen==0)
			call QUIT
		.elseif(MouseRow == 20 && MouseCol>=62 && MouseCol<=70 && Screen==1)
			jmp Beginning
		.else
			jmp mousecheck
		.endif

InstructionScreen:
;----------- READING AND DISPLAYING INSTRUCTIONS FROM FILE
	MOV AH,0
	MOV AL,13h
	INT 10h

	mov Screen,1

	Call FileReading
	Call ClickBack

	jmp mousecheck

main endp
;-------------------------------   FUNCTIONS  ---------------------------		

PlayScreen proc
;-------------- SCREEN FOR DISPLAYING GAME

;--------  REMOVING MOUSE CURSOR
	mov ax,2
	int 33h
;--------- ENTERING PLAYER NAME
	call PlayerName
;--------- VIDEO MODE
	MOV AH,0
	MOV AL,13h
	INT 10h
	
	call Background

	call Dyno
	call MoveObjects
	call MoveClouds
;-------- KEYBOARD INPUT CHECK
	KeyPress:
		mov ah,0
		int 16h	
	Check:	
		mov ah,1
		int 16h
		
		mov KeyCheck,al
		JZ MOVE		
		; ; AH = BIOS scan code
		 cmp ah,48h
		 je ARROWUP
		 cmp ah,4Bh
		 je ARROWLEFT
		 cmp ah,4Dh
		 je ARROWRIGHT
		 cmp ah,50h
		 je ARROWDOWN
	
ARROWUP:

	mov jrow,0
	mov jumpcheck,0
	mov chkFIX,21

L1:

	.if(lives == 0)
		call RestartScreen
	.endif
 		
	Call Background

	.if(jumpcheck<=9)
		add jrow,3
		inc jumpcheck
	.else
		sub jrow,3
		.if(jrow==0)
			mov jumpcheck,0
		.endif
	.endif	
	
	call Dyno

	call AllMovements
	call AllCollisions
	call TimerDelay
	call AllIncrements

dec chkFIX
cmp chkFIX,1
jne L1

mov al,0
jmp KeyPress

ARROWDOWN:

	mov jrow,0
	mov jumpcheck,0
	mov chkFIX,21

L2:

	.if(lives == 0)
		call RestartScreen
	.endif
 		
	Call Background

	call CrouchDyno

	call AllMovements
	call AllCollisions
	call TimerDelay
	call AllIncrements

dec chkFIX
cmp chkFIX,1
jne L2

mov al,0
jmp KeyPress

ARROWLEFT:		

.if(dstart>=50)

	.if(lives == 0)
		call RestartScreen
	.endif
 
	Call Background

	sub jstart,3
	sub jend,3

	call Dyno
		
	call AllMovements
	call AllCollisions
	call TimerDelay
	call AllIncrements
	
.endif

mov al,0
jmp KeyPress
		
ARROWRIGHT:

.if(dstart <= 280)

	.if(lives == 0)
		call RestartScreen
	.endif
 
	Call Background

	add jstart,3
	add jend,3

	call Dyno
	
	call AllMovements
	call AllCollisions
	call TimerDelay
	call AllIncrements
	
.endif

mov al,0
jmp KeyPress

MOVE:
 
	.if(lives == 0)
		call RestartScreen
	.endif
 
	Call Background

	.if(jumpcheck<=1)
		add jrow,1
		inc jumpcheck
	.else
		sub jrow,1
		.if(jrow==0)
			mov jumpcheck,0
		.endif
	.endif	
	
	call Dyno

	call AllMovements
	call AllCollisions
	call TimerDelay
	call AllIncrements
	
jmp CHECK

ret
PlayScreen endp

;-------- DYNOOO JUMP/MOVE
Dyno Proc

	mov color,00000010b
	mov si,0		
JumpDynoPrint1:

	mov bx,DynoRow[si]
	mov break,bx 
	sub bx,jrow
	mov drow,bx

	mov bx,DStartCol[si]
	add bx,jstart
	mov dstart,bx

	mov bx,DEndCol[si]
	add bx,jend
	mov dend,bx

JumpDynoPrint2:

	repeat 3
		mov ah,0Ch
		mov al,color
		mov cx,dstart
		mov dx,drow
		int 10h

		inc drow
	endm

	.if(break==0)
				
		mov bx,117
		sub bx,jrow
		mov drow,bx

		mov bx,95
		add bx,jstart
		mov dstart,bx

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
	mov dstart,bx
	endm

	.elseif(dstart<bx)
		inc dstart
		sub drow,3
		jmp JumpDynoPrint2

	.elseif(dstart==bx)
		add si,2
		jmp JumpDynoPrint1

	.endif
ret
Dyno endp

;-------- DYNOOO CROUCH
CrouchDyno Proc

	mov color,00000010b
	mov si,0

DynoPrint1:

	mov bx,DynoRow[si]
	mov break,bx
	add bx,jrow
	mov drow,bx
	mov ax,jrow

	mov bx,DStartCol[si]
	add bx,jstart
	mov dstart,bx
	mov cx,jstart

	mov bx,DEndCol[si]
	add bx,jend
	mov dend,bx
	mov dx,jend

DynoPrint2:

	repeat 3
		mov ah,0Ch
		mov al,color
		mov cx,dstart
		mov dx,drow
		int 10h

		inc drow
	endm

	.if(si>=32)
		mov jrow,15
		mov jstart,8
		mov jend,8
	.elseif(si>12 && si<32)
		mov jrow,4
	.endif

	.if(break==0)

		mov bx,117
		add bx,jrow
		mov drow,bx

		mov bx,95
		add bx,jstart
		mov dstart,bx

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
	mov dstart,bx
	endm
	
	mov jrow,0
	mov jstart,0
	mov jend,0
	ret

	.elseif(dstart<bx)
		inc dstart
		sub drow,3
		jmp DynoPrint2
		
	.elseif(dstart==bx)
		add si,2
		jmp DynoPrint1
	.endif
	
CrouchDyno endp

;-------- DRAWING SUN
Sun Proc

	mov si,0
SunPrint1:

	mov bx,SunRow1[si]
	mov sunrow,bx

	mov bx,SunStartCol[si]
	mov sunstart,bx

	mov bx,SunEndCol[si]
	mov sunend,bx

SunPrint2:

	repeat 3
		mov ah,0Ch
		mov al,suncolor
		mov cx,sunstart
		mov dx,sunrow
		int 10h

		inc sunrow
	endm

	.if(sunstart==0)
		ret
	.elseif(sunstart<bx)
		inc sunstart
		sub sunrow,3
		jmp SunPrint2
	.elseif(sunstart==bx)
		add si,2
		jmp SunPrint1
	.endif

Sun endp

MoveBird proc

	mov color,00000000b
	mov si,0

MoveBirdPrint1:

	mov bx,BirdRow[si]
	mov break,bx
	add bx,hurrow
	mov brow,bx

	mov bx,BStartCol[si]
	sub bx,hurstart
	mov bstart,bx

	mov bx,BEndCol[si]
	sub bx,hurend
	mov bend,bx

MoveBirdPrint2:

	repeat 3
		mov ah,0Ch
		mov al,color
		mov cx,bstart
		mov dx,brow
		int 10h

		inc brow
	endm

	.if(break==0)
		mov bx,88
		add bx,hurrow
		mov brow,bx

		mov bx,257
		sub bx,hurstart
		mov bstart,bx
	
	repeat 2	
		repeat 2
	
		mov ah,0Ch
		mov al,00001111b
		mov cx,bstart
		mov dx,brow
		int 10h
	
		inc bstart
		endm
	inc brow
	mov bstart,bx
	endm
	
		.if(hurstart<=230)
			add hurstart,5
			add hurend,5
		.else
			mov hurstart,0
			mov hurend,0
			mov birdcheck,0
		
			Mov al,bool
			Mov ah,bool2
			XCHG bool,ah       
			XCHG bool2,al
		.endif

	.elseif(bstart<bx)
		inc bstart
		sub brow,3
		jmp MoveBirdPrint2
	.elseif(bstart==bx)
		add si,2
		jmp MoveBirdPrint1
	.endif

ret
MoveBird endp

MoveStone proc

	mov color,00001111b
	mov si,0

MoveStonePrint1:

	mov bx,StoneRow[si]
	mov break,bx
	add bx,hur1row
	mov srow,bx

	mov bx,SStartCol[si]
	sub bx,hur1start
	mov sstart,bx

	mov bx,SEndCol[si]
	sub bx,hur1end
	mov send,bx

MoveStonePrint2:

	repeat 3
		mov ah,0Ch
		mov al,color
		mov cx,sstart
		mov dx,srow
		int 10h

		inc srow
	endm

	.if(break==0)

		.if(hur1start<=270)
			add hur1start,5
			add hur1end,5
		.else
			mov hur1start,0
			mov hur1end,0
			mov stonecheck,0
		.endif

	.elseif(sstart<bx)
		inc sstart
		sub srow,3
		jmp MoveStonePrint2
	.elseif(sstart==bx)
		add si,2
		jmp MoveStonePrint1
	.endif

ret
MoveStone endp

MovePlant proc

	mov color,00000010b
	mov si,0

MovePlantPrint1:

	mov bx,PlantRow[si]
	mov break,bx
	add bx,hur2row
	mov prow,bx

	mov bx,PStartCol[si]
	sub bx,hur2start
	mov pstart,bx

	mov bx,PEndCol[si]
	sub bx,hur2end
	mov pend,bx

MovePlantPrint2:

	repeat 3
		mov ah,0Ch
		mov al,color
		mov cx,pstart
		mov dx,prow
		int 10h

		inc prow
	endm

	.if(break==0)

		.if(hur2start<=260)
			add hur2start,5
			add hur2end,5
		.else
			mov hur2start,0
			mov hur2end,0
			mov plantcheck,0
		.endif
	
	.elseif(pstart<bx)
		inc pstart
		sub prow,3
		jmp MovePlantPrint2
	.elseif(pstart==bx)
		add si,2
		jmp MovePlantPrint1
	.endif

ret
MovePlant endp

MoveClouds proc

	.if(cfix==0)
		add qstart,300
		add qend,300	
		mov cfix,1
	.endif

	mov color,00001111b
	mov si,0

MoveCloudsPrint1:

	mov bx,CloudRow[si]
	mov break,bx
	add bx,qrow
	mov crow,bx

	mov bx,CStartCol[si]
	sub bx,qstart
	mov cstart,bx

	mov bx,CEndCol[si]
	sub bx,qend
	mov cend,bx

MoveCloudsPrint2:

	repeat 3
		mov ah,0Ch
		mov al,color
		mov cx,cstart
		mov dx,crow
		int 10h

		inc crow
	endm

	.if(break==0)
		add qstart,1
		add qend,1
	.elseif(cstart<bx)
		inc cstart
		sub crow,3
		jmp MoveCloudsPrint2
	.elseif(cstart==bx)
		add si,2
		jmp MoveCloudsPrint1
	.endif

ret
MoveClouds endp

;-------- DRAWING OTHER OBJECTS
MoveObjects Proc

	.if(ofix==0)
		add objstart,300
		add objend,300	
		mov ofix,1
	.endif

	mov si,0
	mov color,00000000b
MoveObjectPrint1:

	mov bx,ObjectRow[si]
	mov break,bx
	add bx,objrow
	mov orow,bx

	mov bx,OStartCol[si]
	sub bx,objstart
	mov ostart,bx

	mov bx,OEndCol[si]
	sub bx,objend
	mov oend,bx

MoveObjectPrint2:

	repeat 3
		mov ah,0Ch
		mov al,color
		mov cx,ostart
		mov dx,orow
		int 10h

		inc orow
	endm
	
	.if(break==0)	
		add objstart,5
		add objend,5
		ret
	.elseif(ostart<bx)
		inc ostart
		sub orow,3
		jmp MoveObjectPrint2
	.elseif(ostart==bx)
		add si,2
		jmp MoveObjectPrint1
	.endif

MoveObjects endp

MoveHeart proc

	mov color,00000100b
	mov si,0

MoveHeartPrint1:

	mov bx,ExtraRow[si]
	mov break,bx
	add bx,liferow
	mov erow,bx

	mov bx,EStartCol[si]
	sub bx,lifestart
	mov estart,bx

	mov bx,EEndCol[si]
	sub bx,lifeend
	mov eend,bx

MoveHeartPrint2:

	repeat 3
		mov ah,0Ch
		mov al,color
		mov cx,estart
		mov dx,erow
		int 10h

		inc erow
	endm

	.if(break==0)

		.if(lifestart<=260)
			add lifestart,5
			add lifeend,5
		.else
			mov lifestart,0
			mov lifeend,0
			mov lifecheck,0
		.endif

	.elseif(estart<bx)
		inc estart
		sub erow,3
		jmp MoveHeartPrint2
	.elseif(estart==bx)
		add si,2
		jmp MoveHeartPrint1
	.endif

ret
MoveHeart endp

;------------------ COLLISIONS 
BirdCollision proc

	mov si,0
	mov di,0

	BirdColl1:

		mov bx,DynoRow[si]
		mov break,bx
		sub bx,jrow
		mov drow,bx
		
		.if(break==0)
			ret
		.endif
		
		mov bx,DStartCol[si]
		add bx,jstart
		mov dstart,bx

		mov bx,DEndCol[si]
		add bx,jend
		mov dend,bx
		mov ax,dend

	BirdColl2:

		mov bx,BStartCol[di]
		sub bx,hurstart
		mov bstart,bx
		mov cx,bstart

		mov bx,BEndCol[di]
		sub bx,hurend
		mov bend,bx
		mov dx,bend

		mov bx,BirdRow[di]
		mov break,bx
		add bx,hurrow
		mov brow,bx

	BirdColl3:

		.if(break==0)
			add si,2
			mov di,0
			jmp BirdColl1
		.elseif(drow==bx && dstart>=cx && dstart<=dx)
			dec lives
			mov hurstart,0
			mov hurend,0
			mov birdcheck,0
			
			Mov al,bool
			Mov ah,bool2
			XCHG bool,ah       
			XCHG bool2,al
		
			CALL TimerDelay2
			ret
		.elseif(dstart<ax)
			inc dstart
			jmp BirdColl3
		.else
			mov bx,DStartCol[si]
			add bx,jstart
			mov dstart,bx
	
			add di,2
			jmp BirdColl2
		.endif
		
BirdCollision endp

PlantCollision proc

	mov si,0
	mov di,0

PlantColl1:

	mov bx,DynoRow[si]
	mov break,bx
	sub bx,jrow
	mov drow,bx

	.if(break==0)
		ret
	.endif

	mov bx,DStartCol[si]
	add bx,jstart
	mov dstart,bx

	mov bx,DEndCol[si]
	add bx,jend
	mov dend,bx
	mov ax,dend

PlantColl2:

	mov bx,PStartCol[di]
	sub bx,hur2start
	mov pstart,bx
	mov cx,pstart

	mov bx,PEndCol[di]
	sub bx,hur2end
	mov pend,bx
	mov dx,pend

	mov bx,PlantRow[di]
	mov break,bx

	add bx,hur2row
	mov prow,bx

PlantColl3:

	.if(break==0)
		add si,2
		mov di,0
		jmp PlantColl1
	.elseif(drow==bx && dstart>=cx && dstart<=dx)
		dec lives
		mov hur2start,0
		mov hur2end,0
		mov plantcheck,0
		CALL TimerDelay2
		ret
	.elseif(dstart<ax)
		inc dstart
		jmp PlantColl3
	.else
		mov bx,DStartCol[si]
		add bx,jstart
		mov dstart,bx
		
		add di,2
		jmp PlantColl2
	.endif
	
PlantCollision endp

StoneCollision proc

	mov si,0
	mov di,0

StoneColl1:

	mov bx,DynoRow[si]
	mov break,bx
	sub bx,jrow
	mov drow,bx

	.if(break==0)
		ret
	.endif

	mov bx,DStartCol[si]
	add bx,jstart
	mov dstart,bx

	mov bx,DEndCol[si]
	add bx,jend
	mov dend,bx
	mov ax,dend

StoneColl2:

	mov bx,SStartCol[di]
	sub bx,hur1start
	mov sstart,bx
	mov cx,sstart

	mov bx,SEndCol[di]
	sub bx,hur1end
	mov send,bx
	mov dx,send

	mov bx,StoneRow[di]
	mov break,bx
	add bx,hur1row
	mov srow,bx

StoneColl3:

	.if(break==0)
		add si,2
		mov di,0
		jmp StoneColl1
	.elseif(drow==bx && dstart>=cx && dstart<=dx)
		dec lives
		mov hur1start,0
		mov hur1end,0
		mov stonecheck,0
		CALL TimerDelay2
		ret
	.elseif(dstart<ax)
		inc dstart
		jmp StoneColl3
	.else
		mov bx,DStartCol[si]
		add bx,jstart
		mov dstart,bx
	
		add di,2
		jmp StoneColl2
	.endif
	
StoneCollision endp

HeartCollision proc

	mov si,0
	mov di,0

HeartColl1:

	mov bx,DynoRow[si]
	mov break,bx
	sub bx,jrow
	mov drow,bx

	.if(break==0)
		ret
	.endif

	mov bx,DStartCol[si]
	add bx,jstart
	mov dstart,bx

	mov bx,DEndCol[si]
	add bx,jend
	mov dend,bx
	mov ax,dend

HeartColl2:

	mov bx,EStartCol[di]
	sub bx,lifestart
	mov estart,bx
	mov cx,estart

	mov bx,EEndCol[di]
	sub bx,lifeend
	mov eend,bx
	mov dx,eend

	mov bx,ExtraRow[di]
	mov break,bx
	add bx,liferow
	mov erow,bx

HeartColl3:

	.if(break==0)
		add si,2
		mov di,0
		jmp HeartColl1
	.elseif(drow==bx && dstart>=cx && dstart<=dx)
		inc lives
		mov lifestart,0
		mov lifeend,0
		mov lifecheck,0
		call TimerDelay3
		ret
	.elseif(dstart<ax)
		inc dstart
		jmp HeartColl3
	.else
		mov bx,DStartCol[si]
		add bx,jstart
		mov dstart,bx
	
		add di,2
		jmp HeartColl2
	.endif
	
HeartCollision endp

;------- DRAWING BACKGROUND OF PLAY SCREEN
Background Proc

	mov ah, 07h
	mov al, 4 
	mov bh, 00000000b 
	mov ch, 0  
	mov cl, 0  
	mov dh, 4 
	mov dl, 40 
	int 10h

	mov ah, 07h
	mov al, 18 
	mov bh, bgcolor 
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

	CALL PrintScore
	call PointsConvert
	call PrintPoints
	call Hearts
	call PrintName
	mov color,00000000b
	Call DrawLine
	Call Sun
	
ret
Background endp

PrintScore proc
		
	mov CHARROW,1
	mov CHARCOL,1
	mov Screen,2
	mov si,0

ScorePrint:
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
		jmp ScorePrint
	.elseif(al=='/')
		add CHARROW,1
		mov CHARCOL,65
		inc si
		jmp ScorePrint
	.elseif(al=='$')
		ret
	.else
		mov  bh, 0          
		mov bl, 00000100b   
		mov cx,1           
		int  10h
			
		inc si
		add CHARCOL,1
	
		jmp ScorePrint
	.endif

PrintScore endp

DrawLine proc
;------- DRAWING A LINE USING PIXELS
mov bx,0
mov si,160
repeat 3

	repeat 320
		mov ah,0Ch
		mov al,color
		mov cx,bx
		mov dx,si
		int 10h

		inc bx
	endm

	mov bx,0
	inc si
endm

ret
DrawLine endp

PlayerName proc

	MOV AH,0
	MOV AL,13h
	INT 10h
;Moving Cursor To Print Charecter	
	mov  dh, 8    
	mov  dl, 2    
	mov  bh, 0          
	mov  ah, 02h        
	int  10h
	
	lea dx,PNAME
	mov ah,9
	int 21h

	mov ax,0
	mov di,0

	mov PLAYER[di],'N'
	inc di
	mov PLAYER[di],'A'
	inc di
	mov PLAYER[di],'M'
	inc di
	mov PLAYER[di],'E'
	inc di
	mov PLAYER[di],':'
	inc di

Input1:

	mov ah,1
	int 21h

	cmp al,13
	je Continue1 
		
	mov PLAYER[di],al
	inc di
		
	jmp Input1

Continue1:

ret
PlayerName endp

PrintName proc

	mov CHARROW,1
	mov CHARCOL,8
	;Moving Cursor To Print Charecter	
	mov  dh, CHARROW    
	mov  dl, CHARCOL    
	mov  bh, 0          
	mov  ah, 02h        
	int  10h
	
	lea dx,PLAYER
	mov ah,9
	int 21h
PrintName endp

PointsConvert proc

	mov bx,0
	mov ax,0
	mov si,0

	mov ax,points
	mov bl,100
	div bl

	mov one,al
	mov three,ah

	mov ah,0
	mov bl,10
	div bl

	mov one,al
	mov two,ah

	mov al,three
	mov ah,0
	mov bl,10
	div bl

	mov three,al
	mov four,ah

	add one,48
	mov bl,one
	mov str1[si],bl
	inc si

	add two,48
	mov bl,two
	mov str1[si],bl
	inc si

	add three,48
	mov bl,three
	mov str1[si],bl
	inc si

	add four,48
	mov bl,four
	mov str1[si],bl
	inc si

ret
PointsConvert endp

PrintPoints proc

	mov CHARROW,1
	mov CHARCOL,35
	mov si,0

PointsPrint:
	;Moving Cursor To Print Charecter	
	mov  dh, CHARROW    
	mov  dl, CHARCOL    
	mov  bh, 0          
	mov  ah, 02h        
	int  10h
	
	;Printing Charecter
	mov ah,09h
	mov  al, str1[si]  
	.if(al=='$')
		ret
	.else
		mov  bh, 0          
		mov bl, 00000100b   
		mov cx,1           
		int  10h
			
		inc si
		add CHARCOL,1
	
		jmp PointsPrint
	.endif

PrintPoints endp

Hearts proc

	mov CHARROW,1
	mov CHARCOL,1

	push cx
	mov cx,0
	mov cx,lives

HeartPrint:
	push cx
	;Moving Cursor To Print Charecter	
	mov  dh, CHARROW    
	mov  dl, CHARCOL    
	mov  bh, 0          
	mov  ah, 02h        
	int  10h
	
	;PRINTING HEARTS
	mov ah,09h
	mov al,3
	mov  bh, 0          
	mov bl, 00000100b   
	mov cx,1           
	int  10h
			
	add CHARCOL,1
	pop cx
Loop HeartPrint

pop cx
ret
Hearts endp

AllMovements proc

.if(points<1300)

	.if(stonecheck>=30 && hurstart == 0 && hur2start == 0)
		call MoveStone
	.endif
	.if(birdcheck>=30 && hur1start == 0 && hur2start == 0)
		.if(bool==0)
			mov hurrow,0
		.elseif(bool==1)
			mov hurrow,20
		.endif
		call MoveBird
	.endif	
	.if(plantcheck>=30 && hur1start == 0 && hurstart == 0)
		call MovePlant
	.endif
	.if(lifecheck>=250)
		call MoveHeart
	.endif
	
.else

	.if(stonecheck>=60)
		call MoveStone
	.endif
	.if(birdcheck>=120)
		.if(bool==0)
			mov hurrow,0
		.elseif(bool==1)
			mov hurrow,20
		.endif
		call MoveBird
	.endif
	.if(plantcheck>=30)
		call MovePlant
	.endif
	.if(lifecheck>=250)
		call MoveHeart
	.endif

.endif

call MoveClouds 
call MoveObjects

ret
AllMovements endp

AllCollisions proc

	call PlantCollision
	call BirdCollision
	call StoneCollision
	call HeartCollision

ret
AllCollisions endp

AllIncrements proc

	inc birdcheck
	inc stonecheck
	inc plantcheck
	inc lifecheck

	inc fix
	inc points
	inc bgcount
	.if(fix==30)
		inc objrow
	.elseif(fix==60)
		inc qrow
		mov fix,0
	.endif
	
	.if(points >= 500)
		mov speed,7500H
	.elseif(points >=1000)
		mov speed,6000H
	.elseif(points>=1300)
		mov speed,4500H
	.endif
	
	.if(bgcount<=500)
		mov bgcolor,00001011b
		mov suncolor,00001110b
	.elseif(bgcount>500 && bgcount<=1000)
		mov bgcolor,00001001b
		mov suncolor,00101011b
	.elseif(bgcount>1100 && bgcount<=1300)
		mov bgcolor,00000001b
		mov suncolor,00000111b
	.else
		mov bgcount,0
	.endif

ret
AllIncrements endp

TimerDelay proc 

	MOV CX, 00H
	MOV DX, speed
	MOV AH, 86H      
	INT 15H
		
ret
TimerDelay endp

TimerDelay2 proc 

	mov CHARROW,7
	mov CHARCOL,10

	mov  dh, CHARROW    
	mov  dl, CHARCOL    
	mov  bh, 0          
	mov  ah, 02h        
	int  10h

	lea dx,HIT
	mov ah,9
	int 21h

	MOV CX, 07H
	MOV DX, 5000H
	MOV AH, 86H      
	INT 15H		

ret
TimerDelay2 endp

TimerDelay3 proc 

	mov CHARROW,7
	mov CHARCOL,10

	mov  dh, CHARROW    
	mov  dl, CHARCOL    
	mov  bh, 0          
	mov  ah, 02h        
	int  10h

	lea dx,PLUS
	mov ah,9
	int 21h

	MOV CX, 05H
	MOV DX, 5000H
	MOV AH, 86H      
	INT 15H
		
ret
TimerDelay3 endp

FileReading proc
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
		mov bl, 00000010b 
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
	
ret
FileReading endp

ClickBack proc

	mov CHARROW,20
	mov CHARCOL,70

	mov  dh, CHARROW    
	mov  dl, CHARCOL    
	mov  bh, 0          
	mov  ah, 02h        
	int  10h

	lea dx,BACK
	mov ah,9
	int 21h

ret
ClickBack endp
;----- TO EXIT VIDEO MODE
RestartScreen proc  

	MOV AH,0
	MOV AL,13h
	INT 10h

;------- DRAWING RESTART SCREEN
	mov CHARROW,6
	mov CHARCOL,10
	mov si,0
PrintRestart:	
	;Moving Cursor To Print Charecter	
	mov  dh, CHARROW    
	mov  dl, CHARCOL    
	mov  bh, 0          
	mov  ah, 02h        
	int  10h

	;Printing Charecter
	mov ah,09h
	mov  al, RESTART[si]   
	.if(al=='/')
		add CHARROW,2
		mov CHARCOL,10
		inc si
		jmp PrintRestart
	.elseif(al=='$')	
		jmp continue3
	.else
		mov  bh, 0          
		mov bl, 00001111b   
		mov cx,1             
		int  10h
			
		inc si
		add CHARCOL,1
		jmp PrintRestart
	.endif

continue3:

	mov CHARROW,8
	mov CHARCOL,23
	mov si,0

PointsPrint1:
	;Moving Cursor To Print Charecter	
	mov  dh, CHARROW    
	mov  dl, CHARCOL    
	mov  bh, 0          
	mov  ah, 02h        
	int  10h
	;Printing Charecter
	mov ah,09h
	mov  al, str1[si]  
	.if(al=='$')
		jmp continue
	.else

		mov  bh, 0          
		mov bl, 00001111b   
		mov cx,1           
		int  10h
			
		inc si
		add CHARCOL,1
		jmp PointsPrint1
	.endif

continue:

	mov ah,4CH
	int 21H
ret
RestartScreen endp 

QUIT proc
 
	mov al,3H
	mov ah,0H
	int 10h
 
	mov ah,4CH
	int 21H
ret
QUIT endp

end main
