	SECTION code_compiler
	GLOBAL  _zxn_rom3call

zxn_rom3call_adjstack:
	;; stack: retaddr, af, bc, de, hl, ix
	exx
	ld	hl, 10
	add	hl, sp
	ld	sp, hl
	exx
	;; stack: retaddr	
	ret
	
	;;  on entry, the we have pushed
	;;     continuation, romaddr, hl', af, bc, de, hl, ix, retaddr

_zxn_rom3call:
	;; stack: continuation, romaddr, hl', af, bc, de, hl, ix, retaddr
	pop	af		; return address
	ex	af,af'
	;; stack: continuation, romaddr, hl', af, bc, de, hl, ix
	pop	de		; stash value for ix in de'
	;; stack: continuation, romaddr, hl', af, bc, de, hl
	exx
	pop	hl		; load main registers for call: hl, de, bc, af
	;; stack: continuation, romaddr, hl', af, bc, de
	pop	de
	;; stack: continuation, romaddr, hl', af, bc
	pop	bc
	;; stack: continuation, romaddr, hl', af
	pop	af
	;; stack: continuation, romaddr, hl'
	exx
	pop	hl		; also load hl' for call (because we can?)
	;; stack: continuation, romaddr
	pop	bc		; bc = subroutine to call
	;; stack: continuation
	ex	af,af'
	push	af		; stash retaddr on the stack
	ex	af,af'
	;; stack: continuation, retaddr
	push	ix		; stash ix (used by zsdcc, must be preserved)
	;; stack: continuation, retaddr, ix
	ld	ixh, d		; load ix for the call
	ld	ixl, e		;
	ld	de, afterwards  ; put our own return address on the stack
	push	de		; by hand
	;; stack: continuation, retaddr, ix, (our return addr)
	push	bc
	;; stack: continuation, retaddr, ix, afterwards, romaddr
	exx			; move primary registers into place
	ret			; indirect jump to rom address via return
afterwards:
	;; stack: continuation, retaddr, ix
	exx
	ld	d,ixh		; stash ix into de
	ld	e,ixl
	pop	ix		; recover ix (to make zsdcc happy)
	;; stack: continuation, retaddr
	pop	bc		; recover retaddr into a spare register
	;; stack: continuation
	pop	hl		; recover continuation into hl to jump later
	;; stack: (empty)
	push	bc		; start with the return address, underneath all
	;; stack: retaddr
	exx
	push	af		; push main register values for continuation fn
	;; stack: retaddr, af
	push	bc
	;; stack: retaddr, af, bc
	push	de
	;; stack: retaddr, af, bc, de
	push	hl
	;; stack: retaddr, af, bc, de, hl
	exx
	push	de		; ix value, stashed earlier
	;; stack: retaddr, af, bc, de, hl, ix
	                        ; we return not to our caller, but to the
				; stack adjuster
	ld	de, zxn_rom3call_adjstack
	push	de		; push adjstack
	;; stack: retaddr, af, bc, de, hl, ix, zxn_rom3call_adjstack
	jp	(hl)		; continue with continuation
