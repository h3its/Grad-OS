[bits 16]
[org 0x7C00]
call boot_init
call kernel_load
mov BX, TEMPSUCCESS
call print

call switch_to_32bit
jmp $

boot_init:
	pop bx
	KERNEL_ADDRESS equ 0x1000
	mov bp, 0x9000
	mov sp, bp
	mov [BOOT_DRIVE], dl
	jmp bx

%include "disk_read.asm"
%include "gdt.asm"
%include "switch_modes.asm"
%include "print_string.asm"

TEMPSUCCESS db "got here",0
BOOT_DRIVE db 0
CODE_SEGMENT_INDEX EQU 0x08
DATA_SEGMENT_INDEX EQU 0x10
times 510-($-$$) db 0
dw 0xaa55

