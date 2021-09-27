/*
 * Q2_HW4.asm
 *
 *  Created: 18-Apr-19 10:49:33 PM
 *   Author: Mobasher
 */ 

PARTA:
	
	WDR
	IN R20,WDTCR
	ORI R20,0x0f
	OUT WDTCR,R20
	

PARTB:
	LDI R22,0x20 
	LDI R21,0x48 	
	OUT PORTD, R21
	OUT DDRD, R22
	nop


	
LOOP1:
	SBIS PIND ,3
	JMP ON
	JMP LOOP1


	
ON:
	LDI R24,0x20 
	OUT PORTD,R24
	JMP TIMER
	


TIMER:
	SBIS PIND ,6
	WDR
	jmp TIMER

 