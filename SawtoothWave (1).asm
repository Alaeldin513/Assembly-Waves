;
; AssemblerApplication2.asm
;
; Created: 12/5/2016 4:03:56 PM
; Author : Physics Lab
;


; Replace with your application code
.org	0x0000
		rjmp 		setup
.org	0x0020
		rjmp		ISR_T
.def 	io_set 		=r16		//gen registry for io-setting
.def	workhorse	=r17		//gen registry for inputs/outputs
.def	amp 		=r18		//Amplitude of the waves
.def	temp		=r19		//Registry used to push to stack
.cseg


Setup:	ser 	io_set
		Out		DDRD,io_set		//Setting DDRD as output
		ldi		amp,0			//Setting amp at 0


		ldi 	workhorse,0b00000000	//setting timer0
		Out 	TCCR0A,workhorse		
		Ldi		workhorse,0b00000101	
		Out		TCCR0B,workhorse		
	
		Ldi		workhorse,0b00000001	//seting Timsk0
		sts		TIMSK0,Workhorse


	
		Ldi 	workhorse,low(RAMEND)	//setting stack
		Out		spl,Workhorse
		Ldi		workhorse,high(RAMEND)
		Out		sph,workhorse
		sei


Loop:	out		PORTD,amp				//output amplitude
		rjmp 	loop




ISR_T:	ldi		Temp,SREG
		push	temp
		Inc 	amp						//incremente 
		pop 	temp
		sts		SREG,temp
		reti