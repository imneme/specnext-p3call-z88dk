;;; This code was written by hand!

        SECTION data_compiler
	GLOBAL	_zxn_p3call_err

_zxn_p3call_err:
	defb	0

	SECTION code_compiler
	GLOBAL  zxn_p3cont_errcheck
	
;;; On entry, stack holds
;;;     retaddr, af, bc, de, hl, ix, zxn_p3call_adjstack, handler_retaddr

zxn_p3cont_errcheck:
	jr	nc, is_error
	ld	a, 0		; zero by do so *without* changing flags
	ld	(_zxn_p3call_err), a
	ret
is_error:
	pop	hl		; throw away zxn_p3call_adjstack, not needed
				; (only used if user writes a custom handler)
	pop	hl		; throw away return address
        pop     hl              ; pop value for ix (ignored)
	pop     hl		; pop value for hl (ignored)
	pop     hl		; pop value for de (ignored)
	pop     hl		; pop value for bc (ignored)
	pop     af		; pop value for af (to store)
	ld	(_zxn_p3call_err), a ; store it
	ld	hl, $FFFF	; return -1
	ld	d, h		; even if it's a 32-bit return
	ld	e, l
	ret			; return to retaddr
