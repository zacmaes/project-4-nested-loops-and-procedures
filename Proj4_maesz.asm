TITLE Project Four Nested Loops & Procedures     (Proj4_maesz.asm)

; Author: Zachary Maes
; Last Modified: July 23, 2022
; OSU email address: maesz@oregonstate.edu
; Course number/section:   CS271 Section 400
; Project Number: 4                Due Date: July 24, 2022
; Description: 
;
; Write a program to calculate prime numbers. 
; First, the user is instructed to enter the number of primes to be displayed, and is prompted to enter an integer in the range [1 ... 200]. 
; The user enters a number, n, and the program verifies that 1 ≤ n ≤ 200. If n is out of range, the user is re-prompted until they enter a value in the specified range. 
; The program then calculates and displays the all of the prime numbers up to and including the nth prime. 
; The results must be displayed 10 prime numbers per line, in ascending order, with at least 3 spaces between the numbers. 
; The final row may contain fewer than 10 values.

; REQUIREMENTS:
; 1. The programmer’s name and program title must appear in the output.
; 2. The counting loop (1 to n) must be implemented using the LOOP instruction.
; 3. The main procedure must consist of only procedure calls (with any necessary framing). It should be a readable "list" of what the program will do.
; 4. Each procedure will implement a section of the program logic, i.e., each procedure will specify how the logic of its section is implemented. 
;	The program must be modularized into at least the following procedures and sub-procedures:
;     - introduction
;     - getUserData - Obtain user input
;			+ validate - Validate user input n is in specified bounds
;     - showPrimes - display n prime numbers; utilize counting loop and the LOOP instruction to keep track of the number primes displayed; 
;        candidate primes are generated within counting loop and are passed to isPrime for evaluation
;			+ isPrime - receive candidate value, return boolean (0 or 1) indicating whether candidate value is prime (1) or not prime (0)
;     - farewell
; 5. The upper and lower bounds of user input must be defined as constants.
; 6. The USES directive is not allowed on this project.
; 7. If the user enters a number outside the range [1 ... 200] an error message must be displayed and the user must be prompted to re-enter the number of primes to be shown.
; 8. The program must be fully documented and laid out according to the CS271 Style Guide. 
;	This includes a complete header block for identification, description, etc., a comment outline to explain each section of code, and proper procedure headers/documentation.

INCLUDE Irvine32.inc

; (insert macro definitions here)

; (insert constant definitions here)

; The upper and lower bounds of user input must be defined as constants
LOWER_BOUND = 1
UPPER_BOUND = 200

.data

; (insert variable definitions here)

; Introduction Data
; 1. The programmer’s name and program title must appear in the output.
intro_1 BYTE	"Welcome to Project Four Nested Loops & Procedures by Zachary Maes!",0

; Directions Data
direction_1 BYTE	"Directions: ",0
direction_2 BYTE	"This program calculates and displays all of the prime numbers up to and including the nth prime.",0
direction_3 BYTE	"In a moment, this program will have you enter the number (n) of prime numbers to be displayed.",0
direction_4 BYTE	"The number you enter must be an integer in the range of [1 to 200] inclusive. ",0
direction_5 BYTE	"If you enter a wrong number, the program will reprompt you to enter another number (hopefully correct this time around)",0
direction_6 BYTE	"The results will be displayed 10 prime numbers per line, in ascending order, with at least 3 spaces between the numbers. ",0
direction_7 BYTE	"The final row may contain fewer than 10 values.",0

; GET USER DATA MESSAGE
get_user_input_1 BYTE	"Enter the number of prime numbers would you like to print [1 to 200]: ",0

; 7. If the user enters a number outside the range [1 ... 200] an error message must be displayed and the user must be prompted to re-enter the number of primes to be shown.
; USER INPUT ERROR MESSAGE
error_1 BYTE	"ERROR!",0
error_2 BYTE	"You entered an invalid number. Please Try Again...",0
;	after this, display get_user_input_1 message again.

; Data for entered user int
user_input DWORD	?	; user inputted number n		

.code
main PROC

; (insert executable instructions here)

	call introduction
    call getUserData
		; call validate??? ---  where do I do it?
    call showPrimes
		; isPrime??? --- where?
	call farewell

	Invoke ExitProcess,0	; exit to operating system
main ENDP

; (insert additional procedures here)

introduction PROC


	ret
introduction ENDP

getUserData PROC
	
	; call validate??? ---  where do I do it?
	call validate


	ret
getUserData ENDP



END main
