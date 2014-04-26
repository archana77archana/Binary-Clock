list p=16f877A
#include p16f877A.inc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bsf STATUS,5

movlw 0x06
movwf ADCON1

movlw 0x00
movwf TRISB 
movwf TRISC
movwf TRISD
movwf TRISA
bcf STATUS,5

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PORTB - seconds
; PORTC - minutes
; PORTD - hours

LOOP:
incf PORTB,1
;call Delay

movfw PORTB
movwf 0x50
call CHECK_60
btfsc PORTA,0
incf PORTC,1
btfsc PORTA,0
movlw 0x00
btfsc PORTA,0
movwf PORTB

movfw PORTC
movwf 0x50
call CHECK_60
btfsc PORTA,0
incf PORTD,1
btfsc PORTA,0
movlw 0x00
btfsc PORTA,0
movwf PORTC

goto LOOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHECK_60:
movlw 0x3B
subwf 0x50,0
btfsc STATUS,Z
bsf PORTA,0
btfss STATUS,Z
bcf PORTA,0
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Delay:
X: movlw 0x05
movwf 0x20
X1:
movlw 0xff
movwf 0x21
X2:
movlw 0xff
movwf 0x22
X3:
decfsz 0x22
goto X3
decfsz 0x21
goto X2
decfsz 0x20
goto X1
return


end
