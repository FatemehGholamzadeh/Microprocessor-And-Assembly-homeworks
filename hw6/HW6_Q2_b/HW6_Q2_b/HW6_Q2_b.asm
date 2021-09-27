/*
 * HW6_Q2_b.asm
 *
 *  Created: 30-May-19 3:21:24 PM
 *   Author: Mobasher
 */ 


 .org 0x00
	jmp reset
.org 0x26
	jmp start

reset:
	
	;pord B direction
	ldi R18,0b00001000
	out DDRB, R18

	;port d
	ldi R19,0b11000000
	out PORTD, R19  

	;TCCR0
	ldi R16,0b01100101
	out TCCR0, R16


	;OCR0
	ldi R16,255
	out OCR0,R16


	;TIMSK
	ldi R16,(1<<OCIE0)
	out TIMSK, R16

	; enable interrupts	
	sei
	
start:
	cli
	in R23,PIND
	sbrs R23,6
	rjmp SW1
	sbrs R23,7
	rjmp SW2
	rjmp start

SW1:
	ldi R16,200
	out OCR0,R16
	rjmp start

SW2:
	ldi R16,100
	out OCR0,R16
	rjmp start

	