/*
 * HW3_Q2.asm
 *
 *  Created: 3/29/2019 9:55:50 PM
 *   Author: Mobasher
 */ 

 LDI R21,-10
 LDI R17,$60
 LDI R18,$00
 LDI R19,$80
 LDI R20,$00
 //mov r30,r17
 //mov r31,r18
 //MOV R0,r17
 //mov R1,r18
 //SPM
 
 LOOP:
	mov r30,r17
	mov r31,r18
	inc r17
	lpm r0,Z
	mov r30,r19
	mov r31,r20
	inc r19
	lpm r1,Z
	cp r0,r1
	brne END
	inc r21
	brne LOOP
	ldi r16,$01
	RET
END:
	ldi r16,$00
	RET
	


	


 
