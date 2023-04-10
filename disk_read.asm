kernel_load:
	pusha			;push registers onto stack
	mov AH, 0x02
	mov AL, 0x09
	mov BX, KERNEL_ADDRESS
	mov CH, 0x00
	mov CL, 0x01		;set up registers for disk read
	mov DL, [BOOT_DRIVE]
	mov DH, 0x00
	int 0x13		;run disk read interrupt

	jc error_message	;if carry flag set jump to error message

	cmp al, 0x09		;compare sectors read vs. sectors expected

	jne disk_read_error	;if num read vs. num expected is different print error

	popa			;pop registers off stack

	ret

test_success:
		;calculate address where last byte of bootloader is loaded into kernel memory
	
	cmp byte [0x11FF], 0xAA 	;compare last byte of bootloader to calculated address
	je success
	jne last_byte_error

success:
	mov BX, success_message
	jmp error_message

disk_read_error:
	mov BX, disk_error_message
	jmp error_message

sector_error:
	mov BX, sector_error_message
	jmp error_message

last_byte_error:
	mov BX, last_byte_message
	jmp error_message

error_message:
	pusha
	mov AH, 0x0E

error_message_loop:
	mov AL, [bx]
	cmp AL, 0x0
	je error_message_done
	int 10h			;print stuff
	add bx, 1
	jmp error_message_loop

error_message_done:
	popa
	ret



success_message db "disk read success", 0
disk_error_message db "error: disk could not be read", 0
sector_error_message db "error: sectors read not expected", 0
last_byte_message db "error: last byte not equal", 0
