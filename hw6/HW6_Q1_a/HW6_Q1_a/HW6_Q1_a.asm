/*
 * HW6_Q1_a.asm
 *
 *  Created: 30-May-19 2:28:23 PM
 *   Author: Mobasher
 */ 


jmp RESET
.org $012
jmp TIM0_OVF

RESET:
		//directon of port D
		 ldi r16,0b00110000
		 out DDRD,r16

		 //initializing port D
		 ldi r18,0x00
		 out PORTD,r18

		 //initializing counter
		 ldi r20,2
		 ldi r18,184
		 clr r17
		 //TIMSK
		 ldi r17,(1<<TOIE0)
		 out TIMSK,r17
		 out TCNT0,r17

		 //TCCR0
		 ldi r16,(0<<WGM01)|(0<<WGM00)|(1<<CS00)|(1<<CS01)|(0<<CS02)
		 out TCCR0,r16
		 sei
loop:
		 rjmp loop



TIM0_OVF:
		 dec r18
		 breq first
		 reti


first:       
		 dec r20
		 breq second
		 reti


second:	
    	 ldi r18,0x90
		 ldi r20,0x02
		 in r19,PORTD
		 com r19
		 out PORTD,r19
		 reti