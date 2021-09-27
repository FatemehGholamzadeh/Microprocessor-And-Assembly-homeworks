/*
 * HW3.asm
 *
 *  Created: 3/15/2019 3:39:14 PM
 *   Author: Mobasher
 */ 
main:
	LDI R20,$90
	LDI R21,$00
	OUT SPH,R21
	OUT SPL,R20
	LDI R30,$70
	LDI R31,$00
	//LDI R16,$F0
	//MOV R0,R16
	LDI R16,$ff
	//OUT $20,R16
	//OUT $30,R16
	IN R0,$30
	SWAP R0
	MOV R17,R0
	CBR R17,$08
	MOV R0,R17
	SBRS R0,5
	jmp A
B:
	LDI R18,$05
	MUL R0,R18
	OUT $31,R1
	OUT $30,R0
	jmp C

A:
	STD Z+32,R0
	jmp C

C:
	PUSH R0
	IN R22,$30
	IN R23,$31
	PUSH R22
	PUSH R23
RET


	

