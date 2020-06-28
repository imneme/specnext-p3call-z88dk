	SECTION code_compiler
	GLOBAL  _zxn_p3call

zxn_p3call_adjstack:
	;; stack: retaddr, af, bc, de, hl, ix
	exx
	ld	hl, 10
	add	hl, sp
	ld	sp, hl
	exx
	;; stack: retaddr	
	ret
	
	;;  on entry, the we have pushed
	;;     continuation, callno, himem, af, bc, de, hl, ix, retaddr

_zxn_p3call:
	;; stack: continuation, callno, himem, af, bc, de, hl, ix, retaddr
	pop	af		; return address
	ex	af,af'
	;; stack: continuation, callno, himem, af, bc, de, hl, ix
	pop	hl		; (ix needs to be hl for dot command)
	;; stack: continuation, callno, himem, af, bc, de, hl
	exx
	pop	hl
	;; stack: continuation, callno, himem, af, bc, de
	pop	de
	;; stack: continuation, callno, himem, af, bc
	pop	bc
	;; stack: continuation, callno, himem, af
	pop	af
	;; stack: continuation, callno, himem
	exx
	pop	bc		; c  = RAM bank to be paged (0 or 7)
	;; stack: continuation, callno
	pop	de		; de = +3DOS/IDEDOS/NextZXOS call ID
	;; stack: continuation
	ex	af,af'
	push	af		; stash retaddr
	ex	af,af'
	
	;; stack: continuation, retaddr
	push	ix		; stash ix (used by zsdcc, must be preserved)
	;; stack: continuation, retaddr, ix
	push	iy		; also stash iy (may be messed with by newlib)
	ld	iy, $5c3a       ; set back to the proper value, ERR_NR
	;; stack: continuation, retaddr, ix, iy
	push	hl		; load ix for +3dos (in hl as well for dot
	pop	ix		; commands

	rst	$08		; call p3dos via exsdos API
	defb	$94		; M_P3CALL

	exx
	;; stack: continuation, retaddr, ix, iy
	pop	iy		; recover iy
	;; stack: continuation, retaddr, ix
	pop	ix		; recover ix (to make zsdcc happy)
	;; stack: continuation, retaddr
	pop	bc		; recover retaddr into a spare register
	;; stack: continuation
	pop	de		; recover continuation into a spare register
	push	bc		; start with the return address, underneath all
	;; stack: retaddr
	exx
	push	af		; push register values for continuation fn
	;; stack: retaddr, af
	push	bc
	;; stack: retaddr, af, bc
	push	de
	;; stack: retaddr, af, bc, de
	push	hl
	;; stack: retaddr, af, bc, de, hl
	exx
	push	hl		; (ix in hl' via m_p3dos)
	;; stack: retaddr, af, bc, de, hl, ix
	                        ; we return not to our caller, but to the
				; stack adjuster
	ld	bc, zxn_p3call_adjstack
	push	bc		; push adjstack
	;; stack: retaddr, af, bc, de, hl, ix, zxn_p3call_adjstack
	ex	de,hl
	jp	(hl)		; continue with continuation
