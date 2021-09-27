/*
 * HW7_Q2.asm
 *
 *  Created: 16-May-19 11:26:37 PM
 *   Author: Mobasher
 */ 


.equ	LCD_RS	= 1
.equ	LCD_RW	= 2
.equ	LCD_E	= 3

.def	temp	= r16
.def	argument= r17		;argument for calling subroutines
.def	return	= r18		;return value from subroutines

.org 0
 jmp RESET
 .org $0009
 rjmp ANA_CONV

 RESET:
		   ldi r16,high(RAMEND);
		   out sph,r16;
		   ldi r16,low(RAMEND);
		   out spl,r16 ;
		   sbi DDRD,4
		   ldi r17,0b00100001
		   out ADMUX,r17
		   ldi r18,(0<<ADTS2)|(0<<ADTS1)|(0<<ADTS0)
		   out SFIOR,r18
		   ldi r19,(1<<ADEN)|(1<<ADIE)|(1<<ADPS2)|(1<<ADPS1)
		   out ADCSRA,r19		  
		   sei


loop: 
           rjmp loop

ANA_CONV:
	
	       in r16,ADCH
		   rcall	LCD_init
		   mov  	argument, r16
		   rcall	LCD_putchar
		   ldi r17,0b00010
		   cp r16,r17
		   BRMI label 
		   ldi r18,0b011
		   cp r18,r16
		   BRMI label
		   cbi PORTD,4
		   reti





	label:   
	       sbi PORTD,4
		   reti
	




lcd_command8:	;used for init (we need some 8-bit commands to switch to 4-bit mode!)
	in	temp, DDRA		;we need to set the high nibble of DDRD while leaving
					;the other bits untouched. Using temp for that.
	sbr	temp, 0b11110000	;set high nibble in temp
	out	DDRA, temp		;write value to DDRD again
	in	temp, PortA		;then get the port value
	cbr	temp, 0b11110000	;and clear the data bits
	cbr	argument, 0b00001111	;then clear the low nibble of the argument
					;so that no control line bits are overwritten
	or	temp, argument		;then set the data bits (from the argument) in the
					;Port value
	out	PortA, temp		;and write the port value.
	sbi	PortA, LCD_E		;now strobe E
	nop
	nop
	nop
	cbi	PortA, LCD_E
	in	temp, DDRA		;get DDRD to make the data lines input again
	cbr	temp, 0b11110000	;clear data line direction bits
	out	DDRA, temp		;and write to DDRD
ret

lcd_putchar:
	push	argument		;save the argmuent (it's destroyed in between)
	in	temp, DDRA		;get data direction bits
	sbr	temp, 0b11110000	;set the data lines to output
	out	DDRA, temp		;write value to DDRD
	in	temp, PortA		;then get the data from PortD
	cbr	temp, 0b11111110	;clear ALL LCD lines (data and control!)
	cbr	argument, 0b00001111	;we have to write the high nibble of our argument first
					;so mask off the low nibble
	or	temp, argument		;now set the argument bits in the Port value
	out	PortA, temp		;and write the port value
	sbi	PortA, LCD_RS		;now take RS high for LCD char data register access
	sbi	PortA, LCD_E		;strobe Enable
	nop
	nop
	nop
	cbi	PortA, LCD_E
	pop	argument		;restore the argument, we need the low nibble now...
	cbr	temp, 0b11110000	;clear the data bits of our port value
	swap	argument		;we want to write the LOW nibble of the argument to
					;the LCD data lines, which are the HIGH port nibble!
	cbr	argument, 0b00001111	;clear unused bits in argument
	or	temp, argument		;and set the required argument bits in the port value
	out	PortA, temp		;write data to port
	sbi	PortA, LCD_RS		;again, set RS
	sbi	PortA, LCD_E		;strobe Enable
	nop
	nop
	nop
	cbi	PortA, LCD_E
	cbi	PortA, LCD_RS
	in	temp, DDRA
	cbr	temp, 0b11110000	;data lines are input again
	out	DDRA, temp
ret

lcd_command:	;same as LCD_putchar, but with RS low!
	push	argument
	in	temp, DDRA
	sbr	temp, 0b11110000
	out	DDRA, temp
	in	temp, PortA
	cbr	temp, 0b11111110
	cbr	argument, 0b00001111
	or	temp, argument

	out	PortA, temp
	sbi	PortA, LCD_E
	nop
	nop
	nop
	cbi	PortA, LCD_E
	pop	argument
	cbr	temp, 0b11110000
	swap	argument
	cbr	argument, 0b00001111
	or	temp, argument
	out	PortA, temp
	sbi	PortA, LCD_E
	nop
	nop
	nop
	cbi	PortA, LCD_E
	in	temp, DDRA
	cbr	temp, 0b11110000
	out	DDRA, temp
ret


LCD_getaddr:	;works just like LCD_getchar, but with RS low, return.7 is the busy flag
	in	temp, DDRA
	andi	temp, 0b00001111
	out	DDRA, temp
	cbi	PortA, LCD_RS
	sbi	PortA, LCD_RW
	sbi	PortA, LCD_E
	nop
	in	temp, PinA
	andi	temp, 0b11110000
	mov	return, temp
	cbi	PortA, LCD_E
	nop
	nop
	sbi	PortA, LCD_E
	nop
	in	temp, PinA
	andi	temp, 0b11110000
	swap	temp
	or	return, temp
	cbi	PortA, LCD_E
	cbi	PortA, LCD_RW
ret

LCD_wait:				;read address and busy flag until busy flag cleared
	rcall	LCD_getaddr
	andi	return, 0x80
	brne	LCD_wait
ret
LCD_init:
	ldi	temp, 0b00001110	;control lines are output, rest is input
	out	DDRA, temp
	ldi	argument, 0x20		;in 4-bit mode.
	rcall	LCD_command8		;LCD is still in 8-BIT MODE while writing this command!!!
	rcall	LCD_wait
	ldi	argument, 0x28		;NOW: 2 lines, 5*7 font, 4-BIT MODE!
	rcall	LCD_command		;
	rcall	LCD_wait
	ldi	argument, 0x0F		;now proceed as usual: Display on, cursor on, blinking
	rcall	LCD_command
	rcall	LCD_wait
	ldi	argument, 0x01		;clear display, cursor -> home
	rcall	LCD_command
	rcall	LCD_wait
	ldi	argument, 0x06		;auto-inc cursor
	rcall	LCD_command
ret
	   