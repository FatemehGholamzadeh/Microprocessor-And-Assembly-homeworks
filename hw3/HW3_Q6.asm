/*
 * HW3_Q6.asm
 *
 *  Created: 3/29/2019 9:07:02 PM
 *   Author: Mobasher
 */ 

 LDI R30,$70
 LDI R31,$00
 LDI R16,-10
 LDI R17,$00
 LDI R18,$01
 ST Z+,R17
 ST Z+,R18
 LOOP:
	ADD R17,R18
	ST Z+,R17
	MOV R19,R18
	MOV R18,R17
	MOV R17,R19
	INC R16
	BRNE LOOP
	RET




