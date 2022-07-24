TITLE Project Four     (Proj4_maesz.asm)

; Author: Zachary Maes
; Last Modified: July 24, 2022
; OSU email address: maesz@oregonstate.edu
; Course number/section:   CS271 Section 400
; Project Number: 4            Due Date: July 24, 2022
; Description: 

; This program is divided into multiple procedures and sub-procedures. First the user is greeted and instructions are printed for them to read.
; The user will then enter a number in the range of [1...200] inclusive to which the program will validate that the value is within the range.
; The program validation will continue to ask the user for a new value if they previously entered a value out of bounds.
; After successful validation, the program will calculate that entered number of prime numbers in ascending order. 
; It will print these numbers with at least 3 spaces inbetween each number and 10 results per line.
; Upon successful printing of the prime numbers, the program will give a farewell message and end.

INCLUDE Irvine32.inc

; (insert macro definitions here)

; (insert constant definitions here)

;UPPER AND LOWER BOUNDS
LOWER_BOUND = 1
UPPER_BOUND = 200

.data

; (insert variable definitions here)

; INTRODUCTION DATA
intro_1		BYTE	"Welcome to Project Four Nested Loops & Procedures by Zachary Maes!",0

direction_1 BYTE	"Directions:",0
direction_2 BYTE	"This program calculates and displays all of the prime numbers up to and including the nth prime.",0
direction_3 BYTE	"In a moment, this program will have you enter the number (n) of prime numbers to be displayed.",0
direction_4 BYTE	"The number you enter must be an integer in the range of [1 to 200] inclusive. ",0
direction_5 BYTE	"If you enter a wrong number, the program will reprompt you to enter another number (hopefully correct this time around)",0
direction_6 BYTE	"The results will be displayed 10 prime numbers per line, in ascending order, with at least 3 spaces between the numbers. ",0
direction_7	BYTE	"The final row may contain fewer than 10 values.",0

; GET USER INPUT DATA
get_user_input_1 BYTE	"Enter the number of prime numbers would you like to print [1 to 200]: ",0

user_input		 DWORD	?	; Stores the user input


; VALIDATE USER INPUT DATA
error_1 BYTE	"ERROR!",0
error_2 BYTE	"You entered an invalid number. Please Try Again...",0

; FAREWELL DATA
farewell_prompt BYTE	"WOW... Look at those prime numbers! Have a nice day!",0

; TEST DATA...DELETE--------------
test_gud BYTE	"getUserData",0
test_validate BYTE "validate",0
test_sp BYTE "showPrimes",0
test_ip BYTE "isPrime",0
; --------------------------------

.code
main PROC

; (insert executable instructions here)

	call introduction
    call getUserData
		; call validate --- inside procedure definition below
    call showPrimes
		; call isPrime --- inside procedure definition below 
	call farewell

	Invoke ExitProcess,0	; exit to operating system
main ENDP

; (insert additional procedures here)

introduction PROC
	mov EDX, OFFSET intro_1
	call WriteString
	call CrLf
	call CrLf

	mov EDX, OFFSET direction_1
	call WriteString
	call CrLf

	mov EDX, OFFSET direction_2
	call WriteString
	call CrLf
	
	mov EDX, OFFSET direction_3
	call WriteString
	call CrLf

	mov EDX, OFFSET direction_4
	call WriteString
	call CrLf

	mov EDX, OFFSET direction_5
	call WriteString
	call CrLf

	mov EDX, OFFSET direction_6
	call WriteString
	call CrLf

	mov EDX, OFFSET direction_7
	call WriteString
	call CrLf
	call CrLf

	ret
introduction ENDP

getUserData PROC
	
	mov EDX, OFFSET get_user_input_1
	call WriteString
	call CrLf

	mov EDX, OFFSET test_gud
	call WriteString
	call CrLf

	; eventually call validate
	call validate


	ret
getUserData ENDP

validate PROC
	mov EDX, OFFSET test_validate
	call WriteString
	call CrLf

	ret
validate ENDP

showPrimes PROC
	
	mov EDX, OFFSET test_sp
	call WriteString
	call CrLf

	; eventually call isPrime
	call isPrime
	
	ret
showPrimes ENDP

isPrime PROC
	
	mov EDX, OFFSET test_ip
	call WriteString
	call CrLf

	ret
isPrime ENDP

farewell PROC
	mov EDX, OFFSET farewell_prompt
	call WriteString
	call CrLf

	ret
farewell ENDP

END main
