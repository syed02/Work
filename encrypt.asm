;This program encrypts the message using Vigenere cipher.
;The user will input the message and the key. The program then use the key to
;modify the message into an encrypted message.
;The key is looped as needed to match the length of the message

extern printf
extern scanf

global main

section .text

main:
  ;----------GET THE MESSAGE---------
  ; printf(prompt)
  mov rdi, promptMessage
  mov rax, 0
  call printf

  ; scanf(inputFormat, message)
  mov rdi, inputFormat
  mov rsi, message
  mov rax, 0
  call scanf

  ;----------GET THE KEY------------
  ; printf(promptKey)
  mov rdi, promptKey
  mov rax, 0
  call printf

  ; scanf(inputFormat, key)
  mov rdi, inputFormat
  mov rsi, key
  mov rax, 0
  call scanf

  ;-----------CALL THE _PRINT ACTION---------------
  mov rax, message
  call _print

ending:
  ;------------EXIT THE PROGRAM-------------------
  mov rax, 0
  ret

_print:
  mov rbx, -1 ;create a counter for message

  mov r10, -1 ;create a counter for key

_loop:
  ;increasing/moving the counters
  inc rbx
  inc r10

  mov rax, [message+rbx] ;loop through the message
  mov r8, [key+r10]      ;loop through the key

  mov cl, al ;compare the condition to see if the string end

  cmp r8b, 0          ;if the key ran out reset the counter
  je resetKeyCounter  ;reset the counter for key (r10)

;---------JUMP BACK TO THE START OF THE KEY WHEN THE KEY COUNTER RESET-------
jumpBack:

  sub r8b, "A"
  add al, r8b

  ;jump to subtraction if al is over 90 (Z)
  cmp al, 90
  jg subtraction

;-----THIS IS WHERE THE MODIFICATION GOES ON---------
afterAdding:
  ;push the added al into message, modifying messasge
  cmp cl, 0
  je skipNull
  mov [message+rbx], al

;-------SKIP THE PROCESS IF THE CHAR IS NULL------------------
skipNull:
  cmp cl, 0
  jne _loop

  ; printf(outputFormat, message)
  mov rdi, outputFormat
  mov rsi, message
  mov rax, 0
  call printf

  ret

;--------THIS IS USED TO MAKE SURE THE CHAR IS IN THE ALPHABET----------
subtraction:
  ;if the result of the addition is over 90 (Z) in ascii
  ;add -26 to al, which forced the al back into range (A to Z)
  sub al, 90
  add al, 64

  jmp afterAdding ;continue the process

;----------------RESET THE KEY COUNTER IF THE KEY RAN OUT--------
resetKeyCounter:
  mov r10, 0
  mov r8, [key]
  jmp jumpBack ;after reset the counter jump back to the start of the key


section .data
  promptMessage:db "Enter the message: ", 0
  outputFormat: db "Encrypted message: %s", 0xa, 0
  inputFormat:  db "%s", 0
  promptKey:    db "Enter the key: ", 0


section .bss
  message:  resb 100
  key:      resb 100
