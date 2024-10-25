; --- Mapeamento de Hardware (8051) ---
RS      equ     P1.3    
EN      equ     P1.2    

org 0000h
	LJMP START

org 0030h
START:
	; 0 = 41h
	; 1 = 4Bh
	; 2 = 4Ah
	; 3	= 49h
	; 4 = 48h
	; 5 = 47h
	; 6	= 46h
	; 7 = 45h
	; 8 = 44h
	; 9 = 43h

	MOV 61H, #43h ; 9  
	MOV 62H, #45h ; 7
	MOV 63H, #49h ; 3
	MOV 64H, #4Bh ; 1

	MOV 40H, #'#' 
	MOV 41H, #'0'
	MOV 42H, #'*'
	MOV 43H, #'9'
	MOV 44H, #'8'
	MOV 45H, #'7'
	MOV 46H, #'6'
	MOV 47H, #'5'
	MOV 48H, #'4'
	MOV 49H, #'3'
	MOV 4AH, #'2'
	MOV 4BH, #'1'
	  
	MOV R1, #51H
	MOV R3, #4
MAIN:
	
	acall lcd_init

	
	mov A, #00h
	ACALL posicionaCursor 
	MOV A, #'S'
	ACALL sendCharacter
	MOV A, #'E'
	ACALL sendCharacter	
	MOV A, #'N'
	ACALL sendCharacter
	MOV A, #'H'
	ACALL sendCharacter
	MOV A, #'A'
	ACALL sendCharacter
	MOV A, #3Ah
	ACALL sendCharacter
	MOV A, #07h
	ACALL posicionaCursor


ROTINA:
	ACALL leituraTeclado
	JNB F0, ROTINA  
		
	MOV A, #40h
	ADD A, R0
	MOV R0, A

	MOV @R1, A
	INC R1

	MOV A, @R0  
	    
	ACALL sendCharacter
	CLR F0
	DJNZ R3, ROTINA
	
	MOV R1, #51H
	MOV R0, #61H
	MOV R4, #4

	COMPARACAO:
		
		MOV A, @R0
		MOV B, @R1
		
		CJNE A,B , DIFERENTE

		INC R1
		INC R0
		
		DJNZ R4, COMPARACAO
		SJMP CORRETO

CORRETO:
		MOV P1, #00H ;liga todos os led

		mov A, #00h
		ACALL posicionaCursor 
		MOV A, #'_'
		ACALL sendCharacter
		MOV A, #'_'
		ACALL sendCharacter	
		MOV A, #'_'
		ACALL sendCharacter
		MOV A, #'_'
		ACALL sendCharacter 
		MOV A, #'_'
		ACALL sendCharacter
		MOV A, #'_'
		ACALL sendCharacter	
		MOV A, #'O'
		ACALL sendCharacter
		MOV A, #'P'
		ACALL sendCharacter
		MOV A, #'E'
		ACALL sendCharacter
		MOV A, #'N'
		ACALL sendCharacter	
		MOV A, #'_'
		ACALL sendCharacter
		MOV A, #'_'
		ACALL sendCharacter 
		MOV A, #'_'
		ACALL sendCharacter
		MOV A, #'_'
		ACALL sendCharacter	
		MOV A, #'_'
		ACALL sendCharacter
		MOV A, #'_'
		ACALL sendCharacter

		INT01:
			CPL P3.0
			RETI

		MOTORDC:
			MOV TMOD, #0H
			SETB EA
			SETB ET1
			SETB TR1
			SETB P3.0
			CLR P3.1
			JMP $



		SJMP $
DIFERENTE:
	SJMP FIM

FIM:
		mov A, #00h
		ACALL posicionaCursor 
		MOV A, #'_'
		ACALL sendCharacter
		MOV A, #'_'
		ACALL sendCharacter	
		MOV A, #'_'
		ACALL sendCharacter
		MOV A, #'_'
		ACALL sendCharacter 
		MOV A, #'_'
		ACALL sendCharacter
		MOV A, #'_'
		ACALL sendCharacter	
		MOV A, #'C'
		ACALL sendCharacter
		MOV A, #'L'
		ACALL sendCharacter
		MOV A, #'O'
		ACALL sendCharacter
		MOV A, #'S'
		ACALL sendCharacter	
		MOV A, #'E'
		ACALL sendCharacter
		MOV A, #'_'
		ACALL sendCharacter 
		MOV A, #'_'
		ACALL sendCharacter
		MOV A, #'_'
		ACALL sendCharacter	
		MOV A, #'_'
		ACALL sendCharacter
		MOV A, #'_'
		ACALL sendCharacter
		SJMP $
leituraTeclado:
	MOV R0, #0		
	MOV P0, #0FFh	
	CLR P0.0		
	CALL colScan	
	JB F0, finish		
					
	SETB P0.0		
	CLR P0.1			
	CALL colScan		
	JB F0, finish		
							
	SETB P0.1			
	CLR P0.2			
	CALL colScan	
	JB F0, finish	
						
	SETB P0.2			
	CLR P0.3			
	CALL colScan		
	JB F0, finish		
						
finish:
	RET

colScan:
	JNB P0.4, gotKey	
	INC R0				
	JNB P0.5, gotKey	
	INC R0				
	JNB P0.6, gotKey	
	INC R0				
	RET				
gotKey:
	SETB F0				
	RET				

lcd_init:

	CLR RS		
	CLR P1.7	
	CLR P1.6		
	SETB P1.5		
	CLR P1.4	
	
	SETB EN	
	CLR EN		
	CALL delay		

	SETB EN		
	CLR EN	
	
	SETB P1.7
	
	SETB EN	
	CLR EN		
	CALL delay		

	CLR P1.7		
	CLR P1.6		
	CLR P1.5		
	CLR P1.4		

	SETB EN	
	CLR EN		

	SETB P1.6	
	SETB P1.5	

	SETB EN	
	CLR EN		

	CALL delay	

	CLR P1.7	
	CLR P1.6		
	CLR P1.5		
	CLR P1.4	

	SETB EN	
	CLR EN	

	SETB P1.7	
	SETB P1.6		
	SETB P1.5		
	SETB P1.4		

	SETB EN		
	CLR EN		

	CALL delay	
	RET


sendCharacter:
	SETB RS  	
	MOV C, ACC.7	
	MOV P1.7, C		
	MOV C, ACC.6		
	MOV P1.6, C			
	MOV C, ACC.5		
	MOV P1.5, C			
	MOV C, ACC.4	
	MOV P1.4, C			

	SETB EN		
	CLR EN		

	MOV C, ACC.3	
	MOV P1.7, C		
	MOV C, ACC.2	
	MOV P1.6, C		
	MOV C, ACC.1		
	MOV P1.5, C		
	MOV C, ACC.0		
	MOV P1.4, C		

	SETB EN		
	CLR EN			

	CALL delay		
	CALL delay		
	RET

posicionaCursor:
	CLR RS	
	SETB P1.7		   
	MOV C, ACC.6		
	MOV P1.6, C			
	MOV C, ACC.5		
	MOV P1.5, C			
	MOV C, ACC.4	
	MOV P1.4, C		

	SETB EN			
	CLR EN		

	MOV C, ACC.3	
	MOV P1.7, C			
	MOV C, ACC.2		
	MOV P1.6, C
	MOV C, ACC.1		
	MOV P1.5, C			
	MOV C, ACC.0	
	MOV P1.4, C			

	SETB EN		
	CLR EN			

	CALL delay			
	CALL delay			
	RET

retornaCursor:
	CLR RS	
	CLR P1.7		
	CLR P1.6	
	CLR P1.5		
	CLR P1.4		

	SETB EN		
	CLR EN		

	CLR P1.7		
	CLR P1.6		
	SETB P1.5		
	SETB P1.4		

	SETB EN	
	CLR EN		

	CALL delay		
	RET

clearDisplay:
	CLR RS	
	CLR P1.7		
	CLR P1.6		
	CLR P1.5		
	CLR P1.4		

	SETB EN		
	CLR EN		

	CLR P1.7	
	CLR P1.6	
	CLR P1.5		
	SETB P1.4	

	SETB EN	
	CLR EN		

	CALL delay		
	RET

delay:
	MOV R7, #15
	DJNZ R7, $
	RET
