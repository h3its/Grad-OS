print:
	mov AH, 0x0e
loop:
	mov Al, [bx]
	cmp AL, 0x0
	je done
	int 10h
	add bx, 1
	jmp loop

done:
	popa
	ret
