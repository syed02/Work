;This program check if the word typed by the user is palindrome.
;The user will enter word asking if its palindrome
;If palindrome it will say its a palindrome, otherwise not a palindrome
;This program works by using two counters at different ends of the word
;(head and tail) to compare the characters that being pointed at.
;If they are the same, move the the two counters to the next characters
;toward the center of the word.

extern printf
extern scanf

global main

section .text

  main:
    ;prompt user for word
    ;printf(prompt)
    mov rdi, prompt
    mov rax, 0
    call printf

    ;get user input
    ;scanf(inputFormat, message)
    mov rdi, inputFormat
    mov rsi, message
    mov rax, 0
    call scanf

  mov rbx, -1 ;create counter at the start of the word

  nextChar:
    ;loop through the word to get the length
    inc rbx
    mov dl, [message+rbx]

    ;check for null
    cmp dl, 0
    je compareStrings

    jne nextChar

  compareStrings:
    ;set another counter rcx at the other end
    mov rcx, -1

    checkNextChar:
      ;moving both the counters toward the center of the word
      inc rcx
      dec rbx

      mov r8b, [message+rcx]
      mov r9b, [message+rbx]
      cmp r8b, r9b
      jne notEqual

      ;check if rcx+1 is rbx
      ;(compare the 2 counters pointing to the 2 chars)
      ;if yes, then jump to isEqual
      mov rax, rcx
      inc rax
      cmp rax, rbx
      je isEqual

      cmp rcx, rbx
      je isEqual

      jne checkNextChar

  ;if not the same, jump to exit
  notEqual:
    mov rdi, isNotPalindrome
    mov rax, 0
    call printf
    jmp exit

  ;print the result out if all are the same
  isEqual:
    mov rdi, isPalindrome
    mov rax, 0
    call printf

  exit:
    ;return 0 and exit the program
    mov rax, 0
    ret

section .data
  prompt:           db "Enter a word: ", 0
  inputFormat:      db "%s", 0
  isPalindrome:     db "The word is Palindrome.", 10, 0
  isNotPalindrome:  db "The word is a Not Palindrome.", 10, 0

section .bss
  message: resb 100
