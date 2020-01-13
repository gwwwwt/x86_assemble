mov ax,0xb800
mov ds,ax
mov word [0x00],'a'
mov word [0x02],'s'
mov word [0x04],'m'
jmp $
