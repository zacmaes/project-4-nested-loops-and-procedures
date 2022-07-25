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
intro_1			 BYTE	"Welcome to Project Four Nested Loops & Procedures by Zachary Maes!",0
direction_1		 BYTE	"Directions:",0
direction_2		 BYTE	"This program calculates and displays all of the prime numbers up to and including the nth prime.",0
direction_3		 BYTE	"In a moment, this program will have you enter the number (n) of prime numbers to be displayed.",0
direction_4		 BYTE	"The number you enter must be an integer in the range of [1 to 200] inclusive. ",0
direction_5		 BYTE	"If you enter a wrong number, the program will reprompt you to enter another number (hopefully correct this time around)",0
direction_6		 BYTE	"The results will be displayed 10 prime numbers per line, in ascending order, with at least 3 spaces between the numbers. ",0
direction_7		 BYTE	"The final row may contain fewer than 10 values.",0

; GET USER INPUT DATA
get_user_input_1 BYTE	"Enter the number of prime numbers would you like to print [1 to 200]: ",0
user_input_check DWORD	?		; 0 =  not the correct value --- 1 = correct value
user_input		 DWORD	?		; Stores the user input


; VALIDATE USER INPUT DATA
error_1			 BYTE	"ERROR!",0
error_2			 BYTE	"You entered an invalid number. Please Try Again...",0
is_valid_message BYTE	"Your Number is valid!",0

; Prime Loop DATA
prime_bool		 DWORD	?		; 0 =  not prime --- 1 = prime
prime_spaces	 BYTE	"   ",0	; 3 spaces
line_count		 DWORD  ?		; counts the amount of primes per line

; FAREWELL DATA
farewell_prompt  BYTE	"WOW... Look at those prime numbers! Have a nice day!",0

.code
main PROC
	; (insert executable instructions here)

	call   introduction
    call   getUserData		; calls sub-procedure validate
    call   showPrimes		; calls sub-procedure isPrime
	call   farewell

	Invoke ExitProcess,0	; exit to operating system
main ENDP

; (insert additional procedures here)

; ---------------------------------------------------------------------------------
; Name: introduction
;
; This procedure displays the various intro_prompt and  directions to the user.
;
; Preconditions: global variables intro_1 and direction_[1-7] must be initialized to BYTE strings.
;
; Postconditions: N/A
;
; Receives: Only used global variables described in Preconditions section.
;
; Returns: Only prints original global variables described above.
; ---------------------------------------------------------------------------------

introduction PROC
	mov  EDX, OFFSET intro_1
	call WriteString
	call CrLf
	call CrLf

	mov  EDX, OFFSET direction_1
	call WriteString
	call CrLf

	mov  EDX, OFFSET direction_2
	call WriteString
	call CrLf
	
	mov  EDX, OFFSET direction_3
	call WriteString
	call CrLf

	mov  EDX, OFFSET direction_4
	call WriteString
	call CrLf

	mov  EDX, OFFSET direction_5
	call WriteString
	call CrLf

	mov  EDX, OFFSET direction_6
	call WriteString
	call CrLf

	mov  EDX, OFFSET direction_7
	call WriteString
	call CrLf
	call CrLf

	ret
introduction ENDP


; ---------------------------------------------------------------------------------
; Name: getUserData
;
; This procedure collects an inputted number from the user and then calls on the validate procedure 
; to check if that number is within the range [1...200]. The procedure repeats the prompt if the 
; number is not valid.
;
; Preconditions: 
;	-Global prompt variables must be initialized to BYTE strings.
;	-validate procedure must be defined and operational.
;
; Postconditions: N/A
;
; Receives: user_input_check DWORD from validate procedure.
;
; Returns: user_input DWORD saves the value from EAX at the end of the procedure.
; ---------------------------------------------------------------------------------

getUserData PROC
	mov user_input_check, 0					; (0=not valid, 1=valid) --- initialize to 0
	
	_promptUser:						    ; Prompt the user for an integer
		mov  EDX, OFFSET get_user_input_1
		call WriteString
		call ReadInt						; EAX now has the user input

	call validate							
	
	cmp  user_input_check, 1				; check user_input_check and decided where to jump
	JNE	 _promptUser

	mov  user_input, EAX					; save eax in user_input

	ret
getUserData ENDP

; ---------------------------------------------------------------------------------
; Name: validate
;
; This procedure takes EAX value from getUserData and validates if that value is within the range of [1...200].
; It returns the validation to getUserData.
;
; Preconditions: 
;	-LOWER_BOUND constant must be set to 1
;	-UPPER_BOUND constant must be set to 200.
;	-user_input_check must be set to 0
;	-all prompt global variables must be initialized in the data section.
;
; Postconditions: N/A
;
; Receives: EAX, and variables/constants described in the preconditions section.
;
; Returns: user_input_check DWORD to getUserData.
; ---------------------------------------------------------------------------------

validate PROC
	cmp  EAX, UPPER_BOUND
	JG   _notInRange
	JLE  _lessThanOrEqualToUpper

	_notInRange:							; Error Too High
		mov  EDX, OFFSET error_1			; Error Message 1
		call WriteString
		call CrLf
		
		mov  EDX, OFFSET error_2			; Error Message 2
		call WriteString
		call CrLf
		ret

	_lessThanOrEqualToUpper:
		cmp  EAX, LOWER_BOUND
		JGE _validNumber
		JL  _notInRange

	_validNumber:							; display success message
		mov  EDX, OFFSET is_valid_message
		call WriteString
		call CrLf
		mov user_input_check, 1				; 1 = valid number

	ret
validate ENDP

; ---------------------------------------------------------------------------------
; Name: showPrimes
;
; This procedure takes the validated user_input and creates a loop with that value set to ECX.
; The loop uses isPrime procedure to check if the passed number is prime or not. It recieves a prime_bool value from isPrime
; to determine this.
;
; Preconditions: 
;	-isPrime procedure must be defined
;	-prime_bool DWORD must be initialized in the data section.
;	-user_input must be defined from the prior procedures.
;
; Postconditions: N/A
;
; Receives: user_input, and variables/constants described in the preconditions section.
;
; Returns: prints specified number of prime numbers to the console.
; ---------------------------------------------------------------------------------

showPrimes PROC
	mov ECX, user_input						; loop count set to user_input
	mov EAX, 3								; set the first prime candidate to 3
	mov line_count, 1						; initialize line_count to 1 for first iteration

	prime_candidate_loop:
		call isPrime
		cmp  prime_bool, 1					; 0 =  not prime --- 1 = prime
		JE	 _checkLineCount				; used to be... _printPrime
		JL   _notPrime

		_checkLineCount:
			cmp  line_count, 10
			JE   _isTen
			JNE  _notTen

		_notTen:							; variable line_count
			mov  EDX, OFFSET prime_spaces
			call WriteInt
			call WriteString				; print the necessary space
			INC  line_count
			
			jmp  _endLoop

		_isTen:
			mov  EDX, OFFSET prime_spaces
			call WriteInt
			call WriteString				; print the necessary space
			call CrLf
			mov  line_count, 1
			
			jmp  _endLoop

		_notPrime:
			INC  ECX						; increment ecx up 1 to reset the loop counter if their is no prime number
			jmp  _endLoop
			
		_endLoop:
			INC  EAX						; increment eax to give the next prime candidate before the next loop iteration

		LOOP prime_candidate_loop

	ret
showPrimes ENDP

; ---------------------------------------------------------------------------------
; Name: isPrime
;
; This procedure takes the EAX and ECX register values from showPrimes procedure and uses them to create
; an innerLoop that checks if the current iteration is a prime number. It then returns prime_bool to showPrimes.
;
; Preconditions: 
;	-EAX and ECX must be given from showPrimes.
;	-EAX and ECX must first be pushed to the stack in order to save their values for use later.
;
; Postconditions: EAX and ECX must be popped from the stack to retrieve the original values.
;
; Receives: EAX, ECX and prime_bool
;
; Returns: prime_bool (0 = not prime or 1 = prime)
; ---------------------------------------------------------------------------------

isPrime PROC
	; SAVE ON STACK ECX and EAX -------------------------------------------------------------
	push ECX								; ECX is loop count set to user_input
	push EAX								; EAX is the prime candidate, last in, first out!
	; ---------------------------------------------------------------------------------------
	
	mov ECX, EAX							; make innerLoop count on ECX
	sub ECX, 1								; prep ecx to be one less than the prime candidate
	
	innerLoop:
		mov EDX, 0							; clear EDX for div
		div ECX
		cmp EDX, 0
		JE  _edxIsZero
		JNE _endItteration					; not prime on this iteration

		_edxIsZero:							;check ecx
			cmp ecx, 1
			JE  _ecxIsOne
			jG  _ecxIsNotOne

		_ecxIsOne:							; this is a prime number
			mov prime_bool, 1				; return bool (0 = not prime or 1 = prime)
			jmp _endItteration

		_ecxIsNotOne:						; this is not a prime number
			mov prime_bool, 0				; return bool (0 = not prime or 1 = prime)
			mov ECX, 1						; close loop with ecx change
			jmp _endItteration
			
		_endItteration:						; not prime on this iteration
			pop EAX							; reinitialize EAX from stack
			push EAX						; re-save EAX on the stack

	LOOP innerLoop

	pop EAX									; BRING BACK ORIGINAL EXC and EAX from Stack
	pop ECX

	ret
isPrime ENDP

; ---------------------------------------------------------------------------------
; Name: farewell
;
; This procedure prints a farewell prompt to the user.
;
; Preconditions: farewell_prompt must be defined in the data section.
;
; Postconditions: N/A
;
; Receives: farewell_prompt
;
; Returns: WriteString farewell_prompt
; ---------------------------------------------------------------------------------

farewell PROC
	call CrLf
	mov  EDX, OFFSET farewell_prompt
	call WriteString
	call CrLf

	ret
farewell ENDP

END main
