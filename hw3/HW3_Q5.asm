/*
 * HW3_Q5.asm
 *
 *  Created: 3/29/2019 3:13:22 PM
 *   Author: Mobasher
 */ 

.equ ARRAY=$01 
.org ARRAY 
.db $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19 

LDI R26,$90 
LDI R27,$00
LDI R16,-21 
LDI R30,$01 
LDI R31,$00

CONDITION1:
    LPM R17,z+
	ST X+,R17
	INC R16 

	BREQ CONDITION2 
	BRNE CONDITION1 
	
CONDITION2: 
	
	LDI R21,$00 
	LDI R20,$00 

	LDI R26,$90 
	LDI R27,$00 
	
	LDI R16,-20
	LD R19,X+ 
	RCALL CONDITION3 



CONDITION3: 
		MOV R18,R19 
		LD R19,X+ 
		INC R16 
		BREQ CONDITION6 
		CP R18,R19 
		
		BRLT CONDITION5 

		BRGE CONDITION4 



CONDITION4: 

		LDI R21,$01 
		TST R20 
		BRNE CONDITION9
		RCALL CONDITION3




CONDITION5: 


		LDI R20,$01 
		TST R21 
		BRNE CONDITION9 
		RCALL CONDITION3 



CONDITION6: 

		TST R21 
		
		BRNE CONDITION8

		BREQ CONDITION7 


CONDITION7: 

		LDI R22,$01 
		MOV R0,R22 
		RET 


CONDITION8: 

		LDI R22,$02 
		MOV R0,R22 
		RET 


CONDITION9: 
		LDI R22,$00 
		MOV R0,R22 
		RET 





