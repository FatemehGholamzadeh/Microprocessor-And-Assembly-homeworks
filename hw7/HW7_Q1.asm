/*
 * HW7_Q1.asm
 *
 *  Created: 16-May-19 7:39:49 PM
 *   Author: Mobasher
 */ 


jmp RESET

RESET:
		 ldi r16,high(RAMEND);
		 out sph,r16;
		 ldi r16,low(RAMEND);
		 out spl,r16 ;
		 ldi r17,(1<<ACME)
		 out SFIOR,r17
		 ldi r16,(0<<ACIS1)|(0<<ACIS0)
		 out ACSR,r16
		 ldi r16,(0<<ADEN)
		 out ADCSRA,r16
		 ldi r16,(1<<MUX0)|(0<<MUX1)|(0<<MUX2)
		 out ADMUX,r16
		 ldi r18,(1<<PD5)
		 out DDRD,r18
		 sei
loop:
		 sbic  ACSR,5
		 rjmp off
		 rjmp on
off:
		 cbi PORTD,5
		 rjmp loop
on:
		 sbi PORTD,5
		 rjmp loop
		 