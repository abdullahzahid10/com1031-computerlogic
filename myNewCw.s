.global main
main:

/* The code below shows that I am welcoming the user to the Hangman Game*/
wlcm_msg:
push {r0-r3}
ldr r0, = welcomemessage
bl puts
pop {r0-r3}
//bx lr

//bl wlcm_msg

/*Declaring an array of the secret words*/

push {r0-r3}
mov r0, #0
bl time
bl srand
bl rand
and r0, r0, #0x0F


mov r7, #9		@ Upper Limit of 9 is stored in the register R7
udiv r5, r0, r7		@ This will divide the unsigned value
mul r8, r5, r7		
sub r1, r0, r8		@ To calculate the remainder

ldr r0, =message1
mov r4, #20		@ MESSAGE LENGTH IS 18
mul r5, r1, r4		@ THE RANDOM NUMBER WILL BE MULTIPLIED BY THE MESSAGE LENGTH
add r0, r0, r5		@ DECLARING R0 AS THE CORRECT ADDRESS

mov r4, r0
//bl printf		@ PRINT THE CORRECT MESSAGE
mov r0, #1
mov r1, r4
mov r2, #20
mov r7, #4
svc 0

pop {r0-r3}
//bx lr

//mov r7, #1
//svc 0
/*
@.data
@.align 2
@message1: .asciz "TESTS              "
@message2: .asciz "CHALLENGE          "
@message3: .asciz "UNIVERSITY         "
@message4: .asciz "STUDENTS           "
@message5: .asciz "BALANCE            "
@message6: .asciz "FEEDBACK           "
@message7: .asciz "BINARY             "
@message8: .asciz "INTELLIGENCE       "
@message9: .asciz "CARTOGRAPHERS      "
@message10: .asciz "CHARACTERISTICALLY"

/*This code will Read the letter / Input from user*

	push {r0-r3, lr}
	ldr r0, =message1
	bl printf

	ldr r0, =format
	ldr r1, =number_read
	bl scanf

	ldr r0, =message2
	ldr r1, =number_read
	ldr r1, [r1]
	bl printf

	pop {r0-r3, lr}
	bx lr*/

	mov r0, #1
	ldr r1, =message15
	mov r2, #len
	mov r7, #4
	svc 0

	mov r0, #0
	ldr r1, =key_read
	mov r2, #1
	mov r7, #3
	svc 0


@.data

@message15: .asciz "Please now guess the letter: "

@message16: .asciz "The letter you have guessed is %d\n"

@format: .asciz "%d"

@.align 2
@number_read: .word 0

/*This will read from the array, and display dashes with guessed letters accordingly*/

mov r0, #0		
ldr r1, =key_read	
mov r2, #1		@ Declare how many bytes to read
mov r7, #3		@ System call enabling
svc 0			@ Activates system calls

ldrb r1, [r1]		@ Value from memory location R1 is loaded to Register R1
mov r7, #0		@ Declare R7 AS THE COUNTER LOOP
ldr r5, =word		@ R5 Points to the word
arrayloop:
cmp r7, #wordlen	@ Determine if r7 is equal to the value of array we have declared
beq complete		@ IF ABOVE IS TRUE, THEN JUMP OUT OF LOOP
ldrb r4, [r5], #1	@ ADRESS DATA OF R5 IS NOW LOADED TO R4, R5 IS INCREASED BY 1
cmp r4, r1		@ Check if r4 is equals to r1
bleq correct		@ If above is equal then the user input is valid

add r7, #1		@ This will increase counter for next loop
b arrayloop

correct:

ldr r8, =copyWord	@ R8 POINTS TO FUNCTION COPYWORD
add r8, r7		@ WE MAKE R7 INDEX OF ARRAY
strb r1, [r8]		@ UPDATE FUNCTION WITH CORRECT CHARACTER
bx lr


complete:	

mov r0, #1		
ldr r1, =copyWord	@ R1 IS LOOKING AT COPYWORD FUNC
mov r2, #wordlen	@ R2 IS THE LENGTH
mov r7, #4		@ SYSTEM CALL = WRITE
svc 0

exit:
@mov r7, #1		@ USE TO EXIT SYSTEM CALLS
@svc 0


@.data
@.align 2
@key_read: .byte 0
@.align 2
@word: .asciz "ANYWORD"
@.align 2
@wordlen = .-word-1
@.align 2
@copyWord: .asciz "_____"

/*This code shows that if a user enters a lowercase character, it will move to uppercase*/

mov r5, #0		@ REGISTER IS USED TO COUNTER THE NUMBER OF INPUT CHARACTER

mov r0, #0		
ldr r1, =input		@ Declare where to store input
mov r2, #99		@ Maximum number of bytes to read
mov r7, #3		@ READ SYSTEM CALLS
svc #0			@ MAKE A SYSTEM CALLS

push {r1}		@ SAVE ADDRESSS OF CHARACTER IN R1
loop:
ldrb r3, [r1]		@ R3 HOLDS VALUE OF FIRST CHARACTER
cmp r3, #90		@ Check if ascii code is greater than z


subgt r3, r3, #32
strb r3, [r1]		@ Now we store character to the memory
add r1, r1, #1		@ move to the next character in the memory
add r5, r5, #1		@ We increase the counter for loop
cmp r3, #0		@ see if character is empty
bne loop		@ return to loop if not empty

pop {r1}		@ R1 ADRESS RETURNS TO THE STACK

mov r0, #1		@ 
mov r2, r5		@ R5 STORES THE NUMBER OF BYTES IN THE INPUT CHARACYER
mov r7, #4		@ SYSTEM CALL FOR WRITE FUNCTION
svc #0

mov r7, #1		@ EXIT SYSTEM CALLS
svc #0

.data
.align 2
input: .space 100
.align 2
welcomemessage: .asciz "Welcome to Hangman, Press 0 to Quit at any time\n"

.align 2
message1: .asciz "TESTS              "
message2: .asciz "CHALLENGE          "
message3: .asciz "UNIVERSITY         "
message4: .asciz "STUDENTS           "
message5: .asciz "BALANCE            "
message6: .asciz "FEEDBACK           "
message7: .asciz "BINARY             "
message8: .asciz "INTELLIGENCE       "
message9: .asciz "CARTOGRAPHERS      "
message10: .asciz "CHARACTERISTICALLY"

.align 2
message15: .asciz "\nPlease now guess the letter: "
.align 2
len = .-message15
message16: .asciz "The letter you have guessed is %d\n"

format: .asciz "%d"

.align 2
number_read: .word 0


.align 2
key_read: .byte 0
.align 2
word: .asciz "ANYWORD"
.align 2
wordlen = .-word-1
.align 2
copyWord: .asciz "_____"

