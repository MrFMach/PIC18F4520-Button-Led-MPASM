;******************************************************************************
;   ONE BUTTON TO ON THE LED, ONE BUTTON TO OFF THE LED
;    
;   Studying Assembly Language with PIC18f4520 on PIC-Board kit
;   Using MPASM Compiller and MPLAB X IDE v4.15
;   
;   Author: FABIO MACHADO                                                    
;   GitHub: https://github.com/MrFMach                                       
;******************************************************************************

;******************************************************************************
;List directives
	
    list p=18F4520		;directive to define processor
    
;******************************************************************************
;Includes
    
    #INCLUDE <P18F4520.INC>	;processor specific variable definitions

;******************************************************************************
;Configuration bits

    CONFIG  OSC = HS		;pic-board cristal cscillator = 20 MHz

;******************************************************************************
;I/O define
    
#DEFINE	BUTTON_ON   PORTC,0
#DEFINE BUTTON_OFF  PORTC,1
#DEFINE LED	    PORTB,6

;******************************************************************************
;Reset Vector

RES_VECT    CODE    0x0000	;processor reset vector
    GOTO    START		;go to beginning of program

;******************************************************************************
;Add interrupts here if used
    
;******************************************************************************
;Main program

MAIN_PROG CODE			;let linker place main program

START:
    MOVLW B'11111111'
    MOVWF TRISC		;PORT as input
    MOVLW B'00000000'
    MOVWF TRISB		;PORT as output
    CLRF PORTB
    CLRF PORTC

LED_OFF:
    BCF LED		;turn off led
    BTFSS BUTTON_ON	;bit test
    GOTO LED_OFF	;execute if bit test = 0
    GOTO LED_ON		;execute if bit test = 1
LED_ON:
    BSF LED		;turn on led
    BTFSS BUTTON_OFF	;bit test
    GOTO LED_ON		;execute if bit test = 0
    GOTO LED_OFF	;execute if bit test = 1


;******************************************************************************
;End
    END