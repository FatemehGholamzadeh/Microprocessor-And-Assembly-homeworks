/*
 * HW6_Q1_b.asm
 *
 *  Created: 30-May-19 2:59:18 PM
 *   Author: Mobasher
 */ 


 jmp reset

reset:
		;initializing stack
		ldi r18,high(RAMEND);
		out sph,r18;
		ldi r18,low(RAMEND);
		out spl,r18 ;


		;direction of port B
		ldi r19,0b00001000
		out DDRB,r19
		

		;TCCR0
		ldi r16,(0<<WGM00)|(1<<WGM01)|(0<<COM01)|(1<<COM00)|(1<<CS00)|(0<<CS01)|(1<<CS02)
		out TCCR0,r16

		;OCR0
		ldi r21,0xff
		out OCR0,r21

		;TIMSK
		ldi r22,(1<<OCIE0)|(1<<toie0)
		out TIMSK,r22

		;TCNT0
		ldi r23,0x00
		out TCNT0,r23
		nop
		sei


loop :
		rjmp loop