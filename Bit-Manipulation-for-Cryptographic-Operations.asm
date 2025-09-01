.386
.model flat, stdcall
.stack 4096
include \Irvine\Irvine32.inc

.data
title BYTE "=== Bit Manipulation for Cryptographic Operations ===",0Dh,0Ah,0
menu  BYTE 0Dh,0Ah,"Menu:",0Dh,0Ah,"1 - Rotate Left (ROL)",0Dh,0Ah,"2 - Rotate Right (ROR)",0Dh,0Ah,"3 - XOR with Key",0Dh,0Ah,"4 - Bitwise NOT",0Dh,0Ah,"5 - Set Bit",0Dh,0Ah,"6 - Clear Bit",0Dh,0Ah,"7 - Test Bit",0Dh,0Ah,"8 - Show Binary",0Dh,0Ah,"9 - Exit",0Dh,0Ah,0
promptVal BYTE "Enter 32-bit integer (decimal): ",0
promptKey BYTE "Enter key/bit-position (decimal): ",0
resultMsg BYTE 0Dh,0Ah,"Result (dec): ",0
resultHex BYTE "  (hex): 0x",0
resultBin BYTE "  (bin): ",0
pressAny BYTE 0Dh,0Ah,"Press ENTER to continue...",0
buffBin BYTE 33 dup(0)
nl BYTE 0Dh,0Ah,0

.code
PrintBinary PROC
    pushad
    mov ecx,32
    lea edi,buffBin
    mov esi,edi
    add esi,32
    mov byte ptr [esi],0
    mov ebx,eax
    dec esi
    mov edx,0
.binloop:
    mov edx,ebx
    and edx,1
    add dl,'0'
    mov [esi],dl
    shr ebx,1
    dec esi
    loop .binloop
    lea eax, buffBin
    call WriteString
    popad
    ret
PrintBinary ENDP

Pause PROC
    call ReadChar
    ret
Pause ENDP

main PROC
    call Clrscr
    lea edx,title
    call WriteString
.mainloop:
    lea edx,menu
    call WriteString
    lea edx,promptVal
    call WriteString
    call ReadInt
    mov ebx,eax
    cmp ebx,1
    jl .invalid
    cmp ebx,9
    jg .invalid
    cmp ebx,1
    je .rol
    cmp ebx,2
    je .ror
    cmp ebx,3
    je .xorop
    cmp ebx,4
    je .notop
    cmp ebx,5
    je .setbit
    cmp ebx,6
    je .clrbit
    cmp ebx,7
    je .testbit
    cmp ebx,8
    je .showbin
    cmp ebx,9
    je .exitprog

.invalid:
    lea edx, nl
    call WriteString
    jmp .mainloop

.rol:
    lea edx,promptVal
    call WriteString
    call ReadInt
    mov eax,eax
    lea edx,promptKey
    call WriteString
    call ReadInt
    and eax,0FFFFFFFFh
    and edx,0FFFFFFFFh
    mov ecx,edx
    and ecx,1Fh
    rol eax,cl
    push eax
    lea edx,resultMsg
    call WriteString
    pop eax
    call WriteInt
    lea edx,resultHex
    call WriteString
    call WriteHex
    lea edx,resultBin
    call WriteString
    call PrintBinary
    lea edx,pressAny
    call WriteString
    call Pause
    jmp .mainloop

.ror:
    lea edx,promptVal
    call WriteString
    call ReadInt
    mov eax,eax
    lea edx,promptKey
    call WriteString
    call ReadInt
    and eax,0FFFFFFFFh
    and edx,0FFFFFFFFh
    mov ecx,edx
    and ecx,1Fh
    ror eax,cl
    push eax
    lea edx,resultMsg
    call WriteString
    pop eax
    call WriteInt
    lea edx,resultHex
    call WriteString
    call WriteHex
    lea edx,resultBin
    call WriteString
    call PrintBinary
    lea edx,pressAny
    call WriteString
    call Pause
    jmp .mainloop

.xorop:
    lea edx,promptVal
    call WriteString
    call ReadInt
    mov eax,eax
    lea edx,promptKey
    call WriteString
    call ReadInt
    xor eax,edx
    push eax
    lea edx,resultMsg
    call WriteString
    pop eax
    call WriteInt
    lea edx,resultHex
    call WriteString
    call WriteHex
    lea edx,resultBin
    call WriteString
    call PrintBinary
    lea edx,pressAny
    call WriteString
    call Pause
    jmp .mainloop

.notop:
    lea edx,promptVal
    call WriteString
    call ReadInt
    mov eax,eax
    not eax
    push eax
    lea edx,resultMsg
    call WriteString
    pop eax
    call WriteInt
    lea edx,resultHex
    call WriteString
    call WriteHex
    lea edx,resultBin
    call WriteString
    call PrintBinary
    lea edx,pressAny
    call WriteString
    call Pause
    jmp .mainloop

.setbit:
    lea edx,promptVal
    call WriteString
    call ReadInt
    mov ebx,eax
    lea edx,promptKey
    call WriteString
    call ReadInt
    mov ecx,eax
    and ecx,1Fh
    mov eax,1
    shl eax,cl
    or ebx,eax
    mov eax,ebx
    push eax
    lea edx,resultMsg
    call WriteString
    pop eax
    call WriteInt
    lea edx,resultHex
    call WriteString
    call WriteHex
    lea edx,resultBin
    call WriteString
    call PrintBinary
    lea edx,pressAny
    call WriteString
    call Pause
    jmp .mainloop

.clrbit:
    lea edx,promptVal
    call WriteString
    call ReadInt
    mov ebx,eax
    lea edx,promptKey
    call WriteString
    call ReadInt
    mov ecx,eax
    and ecx,1Fh
    mov eax,1
    shl eax,cl
    not eax
    and ebx,eax
    mov eax,ebx
    push eax
    lea edx,resultMsg
    call WriteString
    pop eax
    call WriteInt
    lea edx,resultHex
    call WriteString
    call WriteHex
    lea edx,resultBin
    call WriteString
    call PrintBinary
    lea edx,pressAny
    call WriteString
    call Pause
    jmp .mainloop

.testbit:
    lea edx,promptVal
    call WriteString
    call ReadInt
    mov ebx,eax
    lea edx,promptKey
    call WriteString
    call ReadInt
    mov ecx,eax
    and ecx,1Fh
    mov eax,1
    shl eax,cl
    and ebx,eax
    cmp ebx,0
    je .bitzero
    lea edx, nl
    call WriteString
    lea edx, resultMsg
    call WriteString
    mov eax,1
    call WriteInt
    jmp .aftertest
.bitzero:
    lea edx, nl
    call WriteString
    lea edx, resultMsg
    call WriteString
    mov eax,0
    call WriteInt
.aftertest:
    lea edx,pressAny
    call WriteString
    call Pause
    jmp .mainloop

.showbin:
    lea edx,promptVal
    call WriteString
    call ReadInt
    mov eax,eax
    lea edx,resultBin
    call WriteString
    call PrintBinary
    lea edx,pressAny
    call WriteString
    call Pause
    jmp .mainloop

.exitprog:
    invoke ExitProcess,0

end main
