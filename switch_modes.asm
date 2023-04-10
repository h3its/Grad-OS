
[bits 32]
begin_32_bit_mode:
	mov ax, DATA_SEGMENT_INDEX ;0x10 for data selector
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ebp, 0x90000
	mov esp, ebp
	jmp KERNEL_ADDRESS
[bits 16]
switch_to_32bit:
	cli 			;turns off interrupts
	lgdt [gdt_descriptor]	;load the gdt descriptor
	mov eax, cr0		;move control register contents to 32 bit register
	or eax, 0x1		;turn on the first bit
	mov cr0, eax		;move contents back to control register
	jmp CODE_SEGMENT_INDEX:begin_32_bit_mode ;code index = 0x08

