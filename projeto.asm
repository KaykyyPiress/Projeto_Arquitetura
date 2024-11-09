      ; --- Mapeamento de Hardware (8051) ---
      RS      equ     P1.3    
      EN      equ     P1.2    
       
      org 0000h
 	LJMP START
       
      org 001Bh ; interrupção do Timer 1
     AJMP TIMER_TRUE ; Salta para a rotina de interrupção do timertrue
      org 001Bh ; interrupção do Timer 1
     AJMP TIMER_FAILD ; Salta para a rotina de interrupção do timefaild
       
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
      
	;senha pré definida
 	MOV 61H, #43h ; 9  
 	MOV 62H, #45h ; 7
 	MOV 63H, #49h ; 3
 	MOV 64H, #4bh ; 1
       
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
      	  
      	
 	MOV R5,#3 ; numero de tentantivas
	acall lcd_init; inicia o lcd
      MAIN:
	MOV R1, #51H ; move pro R1 o endereço 51h 
 	MOV R3, #4 ; numero de digitos da senha
      	
      ;;imprime a mensagem no lcd para digitar a senha
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
 	MOV A, #07h
 	ACALL posicionaCursor
       
       
      ROTINA:
    ;inicia a leitura do teclado
 	ACALL leituraTeclado
 	JNB F0, ROTINA  
      	
	MOV A, #40h
 	ADD A, R0
 	MOV R0, A
       
	MOV @R1, A ;move pro endereço do r1 o digito da senha
 	INC R1; incrementa o r1
       
 	MOV A, @R0  
      	    
 	ACALL sendCharacter
 	CLR F0
 	DJNZ R3, ROTINA ; decrementa o a quantidade de digitos
      	
 	MOV R1, #51H; move pro r1 o endereço dos digitos da senha
 	MOV R0, #61H;  move pro r0 o endereço dos digitos da senha ja setada
 	MOV R4, #4; move pro r4 o numero de vezes que realizará a comparação
       
      	COMPARACAO:
      		
 		MOV A, @R0 ;move pro a o endereço do r0
		MOV B, @R1; move pro b o endereço do r1
      		
 		CJNE A,B , DIFERENTE ;confere se os digitos estão iguais, se tiver iguais 
      							; ele continua a execução, se estiver diferente ele imprime a errada
		INC R1 ; incrementa o r1
 		INC R0; incrementa o r0
      		
		DJNZ R4, COMPARACAO ; decrementa o r4 para conferir os digitos com a senha
		SJMP CORRETO; inicia a função de correto
       
      CORRETO:
 		MOV P1, #0F0H ;liga o led verde
      		
      		;imprime no lcd a mensagem de aberto 
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
       		
			;inicia o motor e faz um giro caso acerte a senha
      		MOTORTRUE:
 			MOV TMOD, #10H
 			MOV TL1, #253
			MOV TH1, #253
 			SETB EA
			SETB ET1
 			SETB TR1
 			SETB P3.0 ; Liga o motor
 			CLR P3.1 ; Define direção do motor
			SJMP $
       
      		; Rotina de interrupção do timertrue para parar o motor após uma rotação
      		TIMER_TRUE:
 			CLR TR1 ; Para o timertrue
 			CLR P3.0 ; Desliga o motor
			CLR ET1 ; Desativa interrupção do timertrue
			RETI ; Retorna da interrupção
       
      ;caso a senha estiver incorreta executara essa função
      DIFERENTE:
    
	;exibe no lcd que a senha esta errada
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
 	MOV A, #'E'
 	ACALL sendCharacter	
 	MOV A, #'R'
 	ACALL sendCharacter
 	MOV A, #'R'
 	ACALL sendCharacter
 	MOV A, #'A'
 	ACALL sendCharacter
 	MOV A, #'D'
	ACALL sendCharacter	
 	MOV A, #'A'
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
	;decrementa o registrador onde possui as chances
 	DJNZ R5, RESET
	;ao fim das chances se inicia o fechamento da fechadura
 	ACALL FIM
       
      RESET:
	;retorna a rotina
 	ACALL MAIN
       
      FIM:	
      	;exibe no lcd que trancou a fechadura
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
 		MOV A, #'D'
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
 		MOV P1, #1FH 
       		
			;inicia o motor e faz ele da dois giros pra identificar
			;o trancamento da fechadura
      		MOTORFAILD:
			MOV TMOD, #10H
 			MOV TL1, #252
 			MOV TH1, #252
 			SETB EA
 			SETB ET1
 			SETB TR1
 			SETB P3.1 ; Liga o motor
 			CLR P3.0 ; Define direção do motor
 			SJMP $
       
      		; Rotina de interrupção do timerfaild para parar o motor após uma rotação
      		TIMER_FAILD:
 			CLR TR1 ; Para o timerfaild
 			CLR P3.0 ; Desliga o motor
 			CLR ET1 ; Desativa interrupção do timerfaild
 			RETI ; Retorna da interrupção
       
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
