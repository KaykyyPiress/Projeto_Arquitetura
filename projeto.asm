      ; --- Mapeamento de Hardware (8051) ---
      RS      equ     P1.3    
      EN      equ     P1.2    
       
      org 0000h
0000| 	LJMP START
       
      org 001Bh ; Vetor de interrupção do Timer 1
001B|     AJMP TIMER_TRUE ; Salta para a rotina de interrupção do Timer 1
      org 001Bh ; Vetor de interrupção do Timer 1
001B|     AJMP TIMER_FAILD ; Salta para a rotina de interrupção do Timer 1
       
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
       
0030| 	MOV 61H, #43h ; 9  
0033| 	MOV 62H, #43h ; 7
0036| 	MOV 63H, #43h ; 3
0039| 	MOV 64H, #43h ; 1
       
003C| 	MOV 40H, #'#' 
003F| 	MOV 41H, #'0'
0042| 	MOV 42H, #'*'
0045| 	MOV 43H, #'9'
0048| 	MOV 44H, #'8'
004B| 	MOV 45H, #'7'
004E| 	MOV 46H, #'6'
0051| 	MOV 47H, #'5'
0054| 	MOV 48H, #'4'
0057| 	MOV 49H, #'3'
005A| 	MOV 4AH, #'2'
005D| 	MOV 4BH, #'1'
      	  
      	
0060| 	MOV R5,#3 ; numero de tentantivas
0062| 	acall lcd_init; inicia o lcd
      MAIN:
0064| 	MOV R1, #51H ; move pro R1 o endereço 51h 
0066| 	MOV R3, #4 ; numero de digitos da senha
      	
      	;;imprime a mensagem no lcd para digitar a senha
0068| 	mov A, #00h
006A| 	ACALL posicionaCursor 
006C| 	MOV A, #'S'
006E| 	ACALL sendCharacter
0070| 	MOV A, #'E'
0072| 	ACALL sendCharacter	
0074| 	MOV A, #'N'
0076| 	ACALL sendCharacter
0078| 	MOV A, #'H'
007A| 	ACALL sendCharacter
007C| 	MOV A, #'A'
007E| 	ACALL sendCharacter
0080| 	MOV A, #3Ah
0082| 	ACALL sendCharacter
0084| 	MOV A, #'_'
0086| 	ACALL sendCharacter
0088| 	MOV A, #'_'
008A| 	ACALL sendCharacter	
008C| 	MOV A, #'_'
008E| 	ACALL sendCharacter
0090| 	MOV A, #'_'
0092| 	ACALL sendCharacter 
0094| 	MOV A, #'_'
0096| 	ACALL sendCharacter		
0098| 	MOV A, #'_'
009A| 	ACALL sendCharacter	
009C| 	MOV A, #'_'
009E| 	ACALL sendCharacter
00A0| 	MOV A, #'_'		
00A2| 	ACALL sendCharacter	
00A4| 	MOV A, #'_'
00A6| 	ACALL sendCharacter
00A8| 	MOV A, #'_'
00AA| 	ACALL sendCharacter 
00AC| 	MOV A, #'_'
00AE| 	ACALL sendCharacter
00B0| 	MOV A, #'_'
00B2| 	ACALL sendCharacter	
00B4| 	MOV A, #07h
00B6| 	ACALL posicionaCursor
       
       
      ROTINA:
      	
00B8| 	ACALL leituraTeclado
00BA| 	JNB F0, ROTINA  
      	
00BD| 	MOV A, #40h
00BF| 	ADD A, R0
00C0| 	MOV R0, A
       
00C1| 	MOV @R1, A ;move pro endereço do r1 o digito da senha
00C2| 	INC R1; incrementa o r1
       
00C3| 	MOV A, @R0  
      	    
00C4| 	ACALL sendCharacter
00C6| 	CLR F0
00C8| 	DJNZ R3, ROTINA ; decrementa o a quantidade de digitos
      	
00CA| 	MOV R1, #51H; move pro r1 o endereço dos digitos da senha
00CC| 	MOV R0, #61H;  move pro r0 o endereço dos digitos da senha ja setada
00CE| 	MOV R4, #4; move pro r4 o numero de vezes que realizará a comparação
       
      	COMPARACAO:
      		
00D0| 		MOV A, @R0 ;move pro a o endereço do r0
00D1| 		MOV B, @R1; move pro b o endereço do r1
      		
00D3| 		CJNE A,B , DIFERENTE ;confere se os digitos estão iguais, se tiver iguais 
      							; ele continua a execução, se estiver diferente ele imprime a errada
00D6| 		INC R1 ; incrementa o r1
00D7| 		INC R0; incrementa o r0
      		
00D8| 		DJNZ R4, COMPARACAO ; decrementa o r4 para conferir os digitos com a senha
00DA| 		SJMP CORRETO; inicia a função de correto
       
      CORRETO:
00DC| 		MOV P1, #0F0H ;liga o led verde
      		
      		;imprime no lcd a mensagem de aberto 
00DF| 		mov A, #00h
00E1| 		ACALL posicionaCursor 
00E3| 		MOV A, #'_'
00E5| 		ACALL sendCharacter
00E7| 		MOV A, #'_'
00E9| 		ACALL sendCharacter	
00EB| 		MOV A, #'_'
00ED| 		ACALL sendCharacter
00EF| 		MOV A, #'_'
00F1| 		ACALL sendCharacter 
00F3| 		MOV A, #'_'
00F5| 		ACALL sendCharacter
00F7| 		MOV A, #'_'
00F9| 		ACALL sendCharacter	
00FB| 		MOV A, #'O'
00FD| 		ACALL sendCharacter
00FF| 		MOV A, #'P'
0101| 		ACALL sendCharacter
0103| 		MOV A, #'E'
0105| 		ACALL sendCharacter
0107| 		MOV A, #'N'
0109| 		ACALL sendCharacter	
010B| 		MOV A, #'_'
010D| 		ACALL sendCharacter
010F| 		MOV A, #'_'
0111| 		ACALL sendCharacter 
0113| 		MOV A, #'_'
0115| 		ACALL sendCharacter
0117| 		MOV A, #'_'
0119| 		ACALL sendCharacter	
011B| 		MOV A, #'_'
011D| 		ACALL sendCharacter
011F| 		MOV A, #'_'
0121| 		ACALL sendCharacter
       
      		MOTORTRUE:
0123| 			MOV TMOD, #10H
0126| 			MOV TL1, #253
0129| 			MOV TH1, #253
012C| 			SETB EA
012E| 			SETB ET1
0130| 			SETB TR1
0132| 			SETB P3.0 ; Liga o motor
0134| 			CLR P3.1 ; Define direção do motor
0136| 			SJMP $
       
      		; Rotina de interrupção do Timer 1 para parar o motor após uma rotação
      		TIMER_TRUE:
0138| 			CLR TR1 ; Para o Timer 1
013A| 			CLR P3.0 ; Desliga o motor
013C| 			CLR ET1 ; Desativa interrupção do Timer 1
013E| 			RETI ; Retorna da interrupção
       
      ;caso a senha estiver incorreta executara essa função
       
      DIFERENTE:
       
013F| 	mov A, #00h
0141| 	ACALL posicionaCursor 
0143| 	MOV A, #'_'
0145| 	ACALL sendCharacter
0147| 	MOV A, #'_'
0149| 	ACALL sendCharacter	
014B| 	MOV A, #'_'
014D| 	ACALL sendCharacter
014F| 	MOV A, #'_'
0151| 	ACALL sendCharacter 
0153| 	MOV A, #'_'
0155| 	ACALL sendCharacter
0157| 	MOV A, #'E'
0159| 	ACALL sendCharacter	
015B| 	MOV A, #'R'
015D| 	ACALL sendCharacter
015F| 	MOV A, #'R'
0161| 	ACALL sendCharacter
0163| 	MOV A, #'A'
0165| 	ACALL sendCharacter
0167| 	MOV A, #'D'
0169| 	ACALL sendCharacter	
016B| 	MOV A, #'A'
016D| 	ACALL sendCharacter
016F| 	MOV A, #'_'
0171| 	ACALL sendCharacter 
0173| 	MOV A, #'_'
0175| 	ACALL sendCharacter
0177| 	MOV A, #'_'
0179| 	ACALL sendCharacter	
017B| 	MOV A, #'_'
017D| 	ACALL sendCharacter
017F| 	MOV A, #'_'
0181| 	ACALL sendCharacter
0183| 	DJNZ R5, RESET
0185| 	ACALL FIM
       
      RESET:
0187| 	ACALL MAIN
       
      FIM:	
      		
0189| 		mov A, #00h
018B| 		ACALL posicionaCursor 
018D| 		MOV A, #'_'
018F| 		ACALL sendCharacter
0191| 		MOV A, #'_'
0193| 		ACALL sendCharacter	
0195| 		MOV A, #'_'
0197| 		ACALL sendCharacter
0199| 		MOV A, #'_'
019B| 		ACALL sendCharacter 
019D| 		MOV A, #'_'
019F| 		ACALL sendCharacter
01A1| 		MOV A, #'C'
01A3| 		ACALL sendCharacter	
01A5| 		MOV A, #'L'
01A7| 		ACALL sendCharacter
01A9| 		MOV A, #'O'
01AB| 		ACALL sendCharacter
01AD| 		MOV A, #'S'
01AF| 		ACALL sendCharacter
01B1| 		MOV A, #'E'
01B3| 		ACALL sendCharacter	
01B5| 		MOV A, #'D'
01B7| 		ACALL sendCharacter
01B9| 		MOV A, #'_'
01BB| 		ACALL sendCharacter 
01BD| 		MOV A, #'_'
01BF| 		ACALL sendCharacter
01C1| 		MOV A, #'_'
01C3| 		ACALL sendCharacter	
01C5| 		MOV A, #'_'
01C7| 		ACALL sendCharacter
01C9| 		MOV A, #'_'
01CB| 		ACALL sendCharacter
01CD| 		MOV P1, #1FH 
       
      		MOTORFAILD:
01D0| 			MOV TMOD, #10H
01D3| 			MOV TL1, #252
01D6| 			MOV TH1, #252
01D9| 			SETB EA
01DB| 			SETB ET1
01DD| 			SETB TR1
01DF| 			SETB P3.1 ; Liga o motor
01E1| 			CLR P3.0 ; Define direção do motor
01E3| 			SJMP $
       
      		; Rotina de interrupção do Timer 1 para parar o motor após uma rotação
      		TIMER_FAILD:
01E5| 			CLR TR1 ; Para o Timer 1
01E7| 			CLR P3.0 ; Desliga o motor
01E9| 			CLR ET1 ; Desativa interrupção do Timer 1
01EB| 			RETI ; Retorna da interrupção
       
      leituraTeclado:
01EC| 	MOV R0, #0		
01EE| 	MOV P0, #0FFh	
01F1| 	CLR P0.0		
01F3| 	CALL colScan	
01F5| 	JB F0, finish		
      					
01F8| 	SETB P0.0		
01FA| 	CLR P0.1			
01FC| 	CALL colScan		
01FE| 	JB F0, finish		
      							
0201| 	SETB P0.1			
0203| 	CLR P0.2			
0205| 	CALL colScan	
0207| 	JB F0, finish	
      						
020A| 	SETB P0.2			
020C| 	CLR P0.3			
020E| 	CALL colScan		
0210| 	JB F0, finish		
      						
      finish:
0213| 	RET
       
      colScan:
0214| 	JNB P0.4, gotKey	
0217| 	INC R0				
0218| 	JNB P0.5, gotKey	
021B| 	INC R0				
021C| 	JNB P0.6, gotKey	
021F| 	INC R0				
0220| 	RET				
      gotKey:
0221| 	SETB F0				
0223| 	RET				
       
      lcd_init:
       
0224| 	CLR RS		
0226| 	CLR P1.7	
0228| 	CLR P1.6		
022A| 	SETB P1.5		
022C| 	CLR P1.4	
      	
022E| 	SETB EN	
0230| 	CLR EN		
0232| 	CALL delay		
       
0234| 	SETB EN		
0236| 	CLR EN	
      	
0238| 	SETB P1.7
      	
023A| 	SETB EN	
023C| 	CLR EN		
023E| 	CALL delay		
       
0240| 	CLR P1.7		
0242| 	CLR P1.6		
0244| 	CLR P1.5		
0246| 	CLR P1.4		
       
0248| 	SETB EN	
024A| 	CLR EN		
       
024C| 	SETB P1.6	
024E| 	SETB P1.5	
       
0250| 	SETB EN	
0252| 	CLR EN		
       
0254| 	CALL delay	
       
0256| 	CLR P1.7	
0258| 	CLR P1.6		
025A| 	CLR P1.5		
025C| 	CLR P1.4	
       
025E| 	SETB EN	
0260| 	CLR EN	
       
0262| 	SETB P1.7	
0264| 	SETB P1.6		
0266| 	SETB P1.5		
0268| 	SETB P1.4		
       
026A| 	SETB EN		
026C| 	CLR EN		
       
026E| 	CALL delay	
0270| 	RET
       
       
      sendCharacter:
0271| 	SETB RS  	
0273| 	MOV C, ACC.7	
0275| 	MOV P1.7, C		
0277| 	MOV C, ACC.6		
0279| 	MOV P1.6, C			
027B| 	MOV C, ACC.5		
027D| 	MOV P1.5, C			
027F| 	MOV C, ACC.4	
0281| 	MOV P1.4, C			
       
0283| 	SETB EN		
0285| 	CLR EN		
       
0287| 	MOV C, ACC.3	
0289| 	MOV P1.7, C		
028B| 	MOV C, ACC.2	
028D| 	MOV P1.6, C		
028F| 	MOV C, ACC.1		
0291| 	MOV P1.5, C		
0293| 	MOV C, ACC.0		
0295| 	MOV P1.4, C		
       
0297| 	SETB EN		
0299| 	CLR EN			
       
029B| 	CALL delay		
029D| 	CALL delay		
029F| 	RET
       
      posicionaCursor:
02A0| 	CLR RS	
02A2| 	SETB P1.7		   
02A4| 	MOV C, ACC.6		
02A6| 	MOV P1.6, C			
02A8| 	MOV C, ACC.5		
02AA| 	MOV P1.5, C			
02AC| 	MOV C, ACC.4	
02AE| 	MOV P1.4, C		
       
02B0| 	SETB EN			
02B2| 	CLR EN		
       
02B4| 	MOV C, ACC.3	
02B6| 	MOV P1.7, C			
02B8| 	MOV C, ACC.2		
02BA| 	MOV P1.6, C
02BC| 	MOV C, ACC.1		
02BE| 	MOV P1.5, C			
02C0| 	MOV C, ACC.0	
02C2| 	MOV P1.4, C			
       
02C4| 	SETB EN		
02C6| 	CLR EN			
       
02C8| 	CALL delay			
02CA| 	CALL delay			
02CC| 	RET
       
      retornaCursor:
02CD| 	CLR RS	
02CF| 	CLR P1.7		
02D1| 	CLR P1.6	
02D3| 	CLR P1.5		
02D5| 	CLR P1.4		
       
02D7| 	SETB EN		
02D9| 	CLR EN		
       
02DB| 	CLR P1.7		
02DD| 	CLR P1.6		
02DF| 	SETB P1.5		
02E1| 	SETB P1.4		
       
02E3| 	SETB EN	
02E5| 	CLR EN		
       
02E7| 	CALL delay		
02E9| 	RET
       
      clearDisplay:
02EA| 	CLR RS	
02EC| 	CLR P1.7		
02EE| 	CLR P1.6		
02F0| 	CLR P1.5		
02F2| 	CLR P1.4		
       
02F4| 	SETB EN		
02F6| 	CLR EN		
       
02F8| 	CLR P1.7	
02FA| 	CLR P1.6	
02FC| 	CLR P1.5		
02FE| 	SETB P1.4	
       
0300| 	SETB EN	
0302| 	CLR EN		
       
0304| 	CALL delay		
0306| 	RET
       
      delay:
0307| 	MOV R7, #15
0309| 	DJNZ R7, $
030B| 	RET
