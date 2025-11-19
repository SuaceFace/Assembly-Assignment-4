; October 22, 2025. 
; Assignment 4
; Takes 10 numbers as input, stored into array. Returns sum and mean of array. Prints array, then rotates the array 9 times, printing each time.

include irvine32.inc

.data
prompt BYTE "Please enter a number: ",0
results1 BYTE "The sum is: ",0
results2 BYTE "The mean is: ",0
results3 BYTE "/10",0
results4 BYTE "The original array: ",0
results5 BYTE "After a rotation: ",0	
myArray DWORD 10 DUP(?)


.code
main proc
	;1. Prompt the user to enter 10 numbers.
	mov ecx, 10						;loop counter
	xor ebp, ebp					;will store sum
	mov ebx, offset myArray
	mov edx, offset prompt

	InputLoop: 
		call writeString
		call readDec
		mov [ebx], eax				;2. save those numbers in a 32-bit integer array.
		add ebp, eax				;3. Calculate the sum of the numbers and display it.
		add ebx, type myArray
	LOOP InputLoop

	mov edx, offset results1
	call writeString
	mov eax, ebp					;move sum into eax to be printed
	call writeDec					;3. Calculate the sum of the numbers and display it.
	call crlf

	mov edx, offset results2		;4. Calculate the mean of the array and display it
	call writeString				
	mov ecx, 10
	xor edx, edx
	div ecx							;sum/10, mean stored in eax, remainder in edx
	call writeDec
	mov eax, ' '
	call writeChar
	mov eax, edx
	call writeDec
	mov edx, offset results3		;prints the "/10"
	call writeString
	call crlf

	mov edx, offset results4		;3. Print the array with the same order it was entered.
	call writeString
	mov ecx, 10						;10 loops needed
	mov ebx, offset myArray			;index to start of array
	FirstArrayLoop:
		mov eax, [ebx]
		call writeDec				;print the value
		mov eax, ' '
		call writeChar				;print a space between values
		add ebx, type myArray
	LOOP FirstArrayLoop				
	call crlf

	mov ebx, offset myArray
	mov ecx, 9						;6. Print the array after each rotation. check the sample run. Rotate 9 times.
	mov edx, offset results5
	ArrayRotationLoop:
		call writeString            ;"After a rotation: "
		mov edi, [myArray+36]		;store last index value

		mov esi, ecx				;save outer loop count
		mov ebp, ebx				;save current index position
		mov eax, [ebx]
		RotateOnceLoop:				;this loop traverses the array and swaps values, starting at the n position
			add ebx, type myArray
			xchg [ebx], eax
		LOOP RotateOnceLoop
		mov [ebp], edi				;move last index value to correct position, at the start

		mov ecx, 10					;set counter to 10
		mov ebx, offset myArray		;set index to start of array
		PrintArrayLoop:				;this loop prints the whole array, similar to before
			mov eax, [ebx]
			call writeDec
			mov eax, ' '
			call writeChar
			add ebx, type myArray
		LOOP PrintArrayLoop

		mov ebx, ebp				;restore saved index
		mov ecx, esi				;restore saved loop counter
		add ebx, type myArray		;increment index
		call crlf					
	LOOP ArrayRotationLoop
	

	exit
main endp
end main

COMMENT @ Sample run
Please enter a number: 1
Please enter a number: 2
Please enter a number: 3
Please enter a number: 4
Please enter a number: 5
Please enter a number: 6
Please enter a number: 7
Please enter a number: 8
Please enter a number: 9
Please enter a number: 10
The sum is: 55
The mean is: 5 5/10
The original array: 1 2 3 4 5 6 7 8 9 10
After a rotation: 10 1 2 3 4 5 6 7 8 9
After a rotation: 10 9 1 2 3 4 5 6 7 8
After a rotation: 10 9 8 1 2 3 4 5 6 7
After a rotation: 10 9 8 7 1 2 3 4 5 6
After a rotation: 10 9 8 7 6 1 2 3 4 5
After a rotation: 10 9 8 7 6 5 1 2 3 4
After a rotation: 10 9 8 7 6 5 4 1 2 3
After a rotation: 10 9 8 7 6 5 4 3 1 2
After a rotation: 10 9 8 7 6 5 4 3 2 1

C:\Users\20631837\Desktop\Project32_VS2022\Debug\Project.exe (process 8756) exited with code 0.
@

