/*
 * HW4_Q1.asm
 *
 *  Created: 18-Apr-19 4:37:41 PM
 *   Author: Mobasher
 */ 
 


/*Note : for working every part you have to comment other parts except delay ,
for example if you want to test partB you have to comment partA and partC except delay lable */
 

partA:
	ldi r16 , $20
	out DDRD , r16
	sbi PIND , 3

offA:
	cbi PORTD , 5
	sbic PIND , 3
	jmp offA

onA:
	sbi PORTD , 5
	sbis PIND , 3
	jmp onA
rjmp partA



partB:
	ldi r16 , $10
	out ddrd , r16
	sbi portd , 6
off:
	cbi portd , 4
	sbic pind , 6
	jmp off
	jmp on

on:
	ldi r17 , $05
on1:
	sbi portd , 4
	call delay
	cbi portd , 4
	call delay
	dec r17
	breq check
	jmp on1


check:
	sbis pind , 6
	jmp on
rjmp partB






partC:

BCDTo7seg: .db 0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F 

	ldi r16 , 0xff
	out DDRB , r16
	ldi r17 , 10
	ldi ZL ,LOW(BCDTo7seg)
	ldi ZH , HIGH(BCDTo7seg)
LOOP:
	lpm r21 , Z+
	out PORTB , r21
	call delay
LOOP2:
	dec r17
	BRNE LOOP
	jmp partC



	


delay:
    LDI     r18 ,   16       ; One clock cycle;
Delay1:
    LDI     r19,   125     ; One clock cycle
Delay2:
    LDI     r20,   250     ; One clock cycle
Delay3:
    DEC     r20            ; One clock cycle
    NOP                     ; One clock cycle
    BRNE    Delay3          ; Two clock cycles when jumping to Delay3, 1 clock when continuing to DEC

    DEC     r19            ; One clock cycle
    BRNE    Delay2          ; Two clock cycles when jumping to Delay2, 1 clock when continuing to DEC

    DEC     r18            ; One clock Cycle
    BRNE    Delay1          ; Two clock cycles when jumping to Delay1, 1 clock when continuing to RET
RET



