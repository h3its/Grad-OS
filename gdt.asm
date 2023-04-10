gdt_start_segment:
	dq 0x0
gdt_code_segment:
	dw 0xffff
	dw 0x0
	db 0x0
	db 10011010b
	db 11001111b
	db 0x0

gdt_data_segment:
	dw 0x0ffff
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0
gdt_end:

gdt_descriptor:
	dw gdt_end - gdt_start_segment - 1
	dd gdt_start_segment

;CODE_SEGMENT_INDEX EQU  gdt_code_segment - gdt_start_segment

;DATA_SEGMENT_INDEX EQU gdt_data_segment - gdt_start_segment


