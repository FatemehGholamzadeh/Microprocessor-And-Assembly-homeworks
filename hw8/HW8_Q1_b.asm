/*
 * HW8_Q1_b.asm
 *
 *  Created: 24-May-19 7:01:51 PM
 *   Author: Mobasher
 */ 

.org 0
 rjmp reset 

.org INT0addr
  rjmp intv0
	
reset:
  //stack
	ldi r16,high(ramend)
	out sph,r16
	ldi r16,low(ramend)
	out spl,r16

	; d direction
	ldi r17 , (0<<DDD2)
	out DDRD , r17
	;pull up
	ldi r16 ,(1<<PD2)
    out PORTD , r16

	;enable interrupt
	ldi r17 , (1<<INT0)
	out GICR , r17

	;MCUCR
	ldi r16,(1<<ISC01)|(0<<ISC00)
	out MCUCR,r16

	; C direction
	ldi r17,$f0
	out DDRC,r17

	ldi r17,$0f
	out portc,r17

	
	 ;UCSRA
	 ldi r16,(0<<U2X)|(0<<MPCM)
	 out UCSRA,r16


	 ;UCSRB
	 ldi r16,(1<<TXEN)|(1<<UCSZ2)|(0<<TXB8)
	 out UCSRB,r16 

	 ;UCSRC
	 ldi r16, (0<<UMSEL)|(1<<UPM1)|(0<<UPM0)|(0<<USBS)|(1<<UCSZ1)|(1<<UCSZ0)|(1<<URSEL)|(0<<UCPOL)
	 out UCSRC,r16


	 ldi r16 , 207
	 out UBRRL,r16 

	sei
	
	

	
loop:
	rjmp loop

intv0:
 KeyFind:
	sbis PINC,3
	rjmp first_column
	sbis PINC,2
	rjmp second_column
	sbis PINC,1
	rjmp third_column
	sbis PINC,0
	rjmp fourth_column
    

first_column:
	sbi PORTC,4
	sbic PINC,3
	rjmp number_3
	cbi portc,4
	sbi PORTC,5
	sbic PINC,3
	rjmp number_7
	cbi PORTC,5
	sbi PORTC,6
	sbic PINC,3
	rjmp B
	cbi PORTC,6
	sbi PORTC,7
	sbic PINC,3
	rjmp F

number_3:
	  cbi PORTC,4
	  ldi r16,3
	  mov r0,r16 
	  ldi r16,'3'
	  ldi r17,0
	  rjmp usart
	  reti

number_7:
	  cbi PORTC,5	  
	  ldi r16,'7'
	  ldi r17,0
	  rjmp usart
	  reti


B:
      cbi PORTC,6	
	  ldi r16,'B'
	  ldi r17,0
	  rjmp usart
	  reti



F:
	  cbi PORTC,7
	  ldi r16,'F'
	  ldi r17,0
	  rjmp usart
	  reti



	  //second_column
second_column:
	sbi PORTC,4
	sbic PINC,2
	rjmp number_2
	cbi PORTC,4
	sbi PORTC,5
	sbic PINC,2
	rjmp number_6
	cbi PORTC,5
	sbi PORTC,6
	sbic PINC,2
	rjmp A
	cbi PORTC,6
	sbi PORTC,7
	sbic PINC,2
	rjmp E

number_2:
      cbi PORTC,4
	  ldi r16,'2'
	  ldi r17,0
	  rjmp usart
	  reti

number_6:
      cbi PORTC,5
	  ldi r16,'6'
	  ldi r17,0
	  rjmp usart
	  reti


A:
cbi PORTC,6
	  ldi r16,'A'
	  ldi r17,0
	  rjmp usart
	  reti



E:
	  cbi PORTC,7
	  ldi r16,'E'
	  ldi r17,0
	  rjmp usart
	  reti



	  //third_column

third_column:
	sbi PORTC,4
	sbic PINC,1
	rjmp number_1
	cbi PORTC,4
	sbi PORTC,5
	sbic PINC,1
	rjmp number_5
	cbi PORTC,5
	sbi PORTC,6
	sbic PINC,1
	rjmp number_9
	cbi PORTC,6
	sbi PORTC,7
	sbic PINC,1
	rjmp D

number_1:
	 cbi PORTC,4
	  ldi r16,'1'
	  ldi r17,0
	  rjmp usart	  
	  reti

number_5:
cbi PORTC,5
	  ldi r16,'5'
	  ldi r17,0
	  rjmp usart
	  reti


number_9:
cbi PORTC,6
	  ldi r16,'9'
	  ldi r17,0
	  rjmp usart
	  reti



D:
	  cbi PORTC,7
	  ldi r16,'D'
	  ldi r17,0
	  rjmp usart
	  reti


	  //fourth_column


fourth_column:
	sbi PORTC,4
	sbic PINC,0
	rjmp number_0
	cbi PORTC,4
	sbi PORTC,5
	sbic PINC,0
	rjmp number_4
	cbi PORTC,5
	sbi PORTC,6
	sbic PINC,0
	rjmp number_8
	cbi PORTC,6
	sbi PORTC,7
	sbic PINC,0
	rjmp C

number_0:
cbi PORTC,4
	  ldi r16,'0'
	  ldi r17,0
	  reti

number_4:
cbi PORTC,5
	  ldi r16,'4'
	  ldi r17,0
	  rjmp usart
	  reti


number_8:
cbi PORTC,6
	  ldi r16,'8'
	  ldi r17,0
	  rjmp usart
	  reti



C:
      cbi PORTC,7
	  ldi r16,'C'
	  ldi r17,0
	  rjmp usart
	  reti










usart:


  sbis UCSRA,UDRE
  rjmp usart
 
  
  cbi UCSRB,TXB8
  sbrc r17,0
  sbi UCSRB,TXB8

 
  out UDR, R16
  reti