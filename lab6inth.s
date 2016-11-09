; Generated by c86 (BYU-NASM) 5.1 (beta) from lab6inth.i
	CPU	8086
	ALIGN	2
	jmp	main	; Jump to program start
	ALIGN	2
myreset:
	; >>>>> Line:	10
	; >>>>> { 
	jmp	L_lab6inth_1
L_lab6inth_2:
	; >>>>> Line:	11
	; >>>>> exit(0); 
	xor	al, al
	push	ax
	call	exit
	add	sp, 2
	mov	sp, bp
	pop	bp
	ret
L_lab6inth_1:
	push	bp
	mov	bp, sp
	jmp	L_lab6inth_2
	ALIGN	2
L_lab6inth_4:
	DW	0
L_lab6inth_5:
	DW	0
L_lab6inth_6:
	DB	"  TickISR: queue overflow! ",0xA,0
	ALIGN	2
myisr:
	; >>>>> Line:	15
	; >>>>> { 
	jmp	L_lab6inth_7
L_lab6inth_8:
	; >>>>> Line:	19
	; >>>>> MsgArray[next].tick = YKTickNum; 
	mov	ax, word [L_lab6inth_4]
	shl	ax, 1
	shl	ax, 1
	mov	si, ax
	add	si, MsgArray
	mov	ax, word [YKTickNum]
	mov	word [si], ax
	; >>>>> Line:	20
	; >>>>> data = (data + 89) % 100; 
	mov	ax, word [L_lab6inth_5]
	add	ax, 89
	cwd
	mov	cx, 100
	idiv	cx
	mov	ax, dx
	mov	word [L_lab6inth_5], ax
	; >>>>> Line:	21
	; >>>>> MsgArray[next].data = data; 
	mov	ax, word [L_lab6inth_4]
	shl	ax, 1
	shl	ax, 1
	add	ax, MsgArray
	mov	si, ax
	add	si, 2
	mov	ax, word [L_lab6inth_5]
	mov	word [si], ax
	; >>>>> Line:	22
	; >>>>> if (YKQPost(MsgQPtr, (void *) &(MsgArray[next])) == 0) 
	mov	ax, word [L_lab6inth_4]
	shl	ax, 1
	shl	ax, 1
	add	ax, MsgArray
	push	ax
	push	word [MsgQPtr]
	call	YKQPost
	add	sp, 4
	test	ax, ax
	jne	L_lab6inth_9
	; >>>>> Line:	23
	; >>>>> printString("  TickISR: queue overf 
	mov	ax, L_lab6inth_6
	push	ax
	call	printString
	add	sp, 2
	jmp	L_lab6inth_10
L_lab6inth_9:
	; >>>>> Line:	24
	; >>>>> else if (++next >= 20) 
	mov	ax, word [L_lab6inth_4]
	inc	ax
	mov	word [L_lab6inth_4], ax
	cmp	ax, 20
	jl	L_lab6inth_11
	; >>>>> Line:	25
	; >>>>> next = 0; 
	mov	word [L_lab6inth_4], 0
L_lab6inth_11:
L_lab6inth_10:
	mov	sp, bp
	pop	bp
	ret
L_lab6inth_7:
	push	bp
	mov	bp, sp
	jmp	L_lab6inth_8
	ALIGN	2
mykeyboard:
	; >>>>> Line:	29
	; >>>>> { 
	jmp	L_lab6inth_13
L_lab6inth_14:
	; >>>>> Line:	30
	; >>>>> GlobalFlag = 1; 
	mov	word [GlobalFlag], 1
	mov	sp, bp
	pop	bp
	ret
L_lab6inth_13:
	push	bp
	mov	bp, sp
	jmp	L_lab6inth_14