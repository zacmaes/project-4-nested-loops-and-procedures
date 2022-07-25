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

user_input_check		 DWORD	?	; 0 =  not the correct value --- 1 = correct value
user_input		 DWORD	?	; Stores the user input


; VALIDATE USER INPUT DATA
error_1 BYTE	"ERROR!",0
error_2 BYTE	"You entered an invalid number. Please Try Again...",0
is_valid_message BYTE	"Your Number is valid!",0

; Prime Loop DATA
prime_bool	DWORD ?	; 0 =  not prime --- 1 = prime

; FAREWELL DATA
farewell_prompt BYTE	"WOW... Look at those prime numbers! Have a nice day!",0

; TEST DATA...DELETE--------------
test_gud BYTE	"getUserData",0
test_backtogud BYTE "BACK TO getUserData after call validate!",0
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
	
	mov user_input_check, 0 ; 0 = not valid number..initialize to this
	; Prompt the user for an integer
	_promptUser:
		mov EDX, OFFSET get_user_input_1
		call WriteString
		call ReadInt
		; EAX now has the user input
		

	; eventually call validate
	
	call validate

	; TEST --- DELETE
	mov EDX, OFFSET test_backtogud
	call WriteString
	call CrLf
	; ----------------------------
	; check user_input_check and decided where to jump
	cmp user_input_check, 1
	JNE	_promptUser


	mov user_input, EAX ; save eax in user_input

	mov EAX, user_input ; write user_input
	call WriteInt
	call CrLf

	

	ret
getUserData ENDP

validate PROC
	;TEST---DELETE----------
	mov EDX, OFFSET test_validate 
	call WriteString
	call CrLf
	; -----------------------------

	cmp EAX, UPPER_BOUND
	JG  _notInRange
	JLE _lessThanOrEqualToUpper


	_notInRange:
		; Error Too High
		mov EDX, OFFSET error_1 ; Error Message 1
		call WriteString
		call CrLf
		
		mov EDX, OFFSET error_2 ; Error Message 2
		call WriteString
		call CrLf
		ret



	_lessThanOrEqualToUpper:
		cmp EAX, LOWER_BOUND
		JGE _validNumber
		JL  _notInRange

	_validNumber:
		; display success message
		mov EDX, OFFSET is_valid_message
		call WriteString
		call CrLf
		mov user_input_check, 1	; 1 = valid number

	ret
validate ENDP

showPrimes PROC
	; TEST --- DELETE
	mov EDX, OFFSET test_sp
	call WriteString
	call CrLf
	; -----------------------------

	; directions: display n prime numbers, 
	; utilize counting loop and LOOP instruction to keep track of the number of primes displayed,
	; candidate primes are generated within counting loop and are passed to isPrime procedure for evaluation...

	mov ECX, user_input ; loop count set to user_input
	mov EAX, 3	; set the first prime candidate to 3

	prime_candidate_loop:
		call isPrime
		cmp prime_bool, 1 ; 0 =  not prime --- 1 = prime
			; if prime...(JE) print the prime
		JE _printPrime
		JL _notPrime

		_printPrime:
			call WriteInt
			; also dont forget to print the necessary space and line breaks
			jmp  _endLoop

		_notPrime:
			INC ECX ; increment exc up 1 to reset the loop counter if their is no prime number
			jmp _endLoop
			
		
		_endLoop:
			INC EAX ; increment eax to give the next prime candidate before the next loop iteration

		LOOP prime_candidate_loop


	; check for bool with cmp like I did in getUserData
	; print if prime
	
	ret
showPrimes ENDP

isPrime PROC

	; TEST --- DELETE
	mov EDX, OFFSET test_ip
	call WriteString
	call CrLf
	; -----------------------------
	; directions:
	; receive candidate prime value eax
	; check if prime logic
	; return bool (0 = not prime or 1 = prime)

	; SAVE ON STACK ECX and EAX
	push ECX	;ECX is loop count set to user_input
	push EAX	; EAX is the prime candidate, last in, first out!

	; make innerLoop count on ECX
	mov ECX, EAX
	sub ECX, 1	;prep ecx to be one less than the prime candidate
	
	innerLoop:
		; clear EDX for div
		mov EDX, 0

		; do a reverse loop, start with ecx at (prime_candidate - 1)
		; check EDX:EAX / ECX and see if remainder(EDX) is 0
		;	-if edx=0 check the value of ecx:
		;		-if ecx >=2..return NOT PRIME
		;		-if ecx = 1...return PRIME
		; EAX / 

		div ECX
		cmp EDX, 0
		JE  _edxIsZero
		JNE _edxIsNotZero

		_edxIsZero:
			;check ecx
			cmp ecx, 1
			JE  _ecxIsOne
			jG _ecxIsNotOne

		_ecxIsOne:
			; this is a prime number

		_ecxIsNotOne:
			; this is not a prime number

		_edxIsNotZero:
			; 


	LOOP innerLoop
	

	;






	; BRING BACK EXC and EAX from Stack
	pop EAX
	pop ECX



	ret
isPrime ENDP

farewell PROC
	mov EDX, OFFSET farewell_prompt
	call WriteString
	call CrLf

	ret
farewell ENDP

END main
