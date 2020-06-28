;;; This code was written by hand!

        SECTION data_compiler
	GLOBAL	_zxn_p3call_results
	GLOBAL 	_zxn_p3call_err
	
_zxn_p3call_results:
results_af:
	defw	0
results_bc:
	defw	0
results_de:	
	defw	0
results_hl:	
	defw	0
results_ix:	
	defw	0
	
; _zxn_p3call_err:
; 	defb	0

	SECTION code_compiler
	GLOBAL  _zxn_p3cont_generic
	
;;; On entry, stack holds
;;;     retaddr, af, bc, de, hl, ix, zxn_p3call_adjstack

_zxn_p3cont_generic:
	pop	hl		; throw away zxn_p3call_adjstack, not needed
				; (only used if user writes a custom handler)
	
        pop     hl              ; pop value for ix (to store)
	ld	(results_ix), hl
	pop     hl		; pop value for hl (to store)
	ld	(results_hl), hl
	pop     hl		; pop value for de (to store)
	ld	(results_de), hl
	pop     hl		; pop value for bc (to store)
	ld	(results_bc), hl
	pop     hl		; pop value for af (to store)
	ld	(results_af), hl

	jr	nc, is_error
	
	xor	a		; zero a (carry status is lost, assume C
				; caller doesn't care)
	ld	(_zxn_p3call_err), a ; store it
	ld	h, a		; return 0
	ld	l, a		; even if it's a 32-bit return
	ld	d, a
	ld	e, a
	ret

is_error:
	ld	a, h		; hl still holds the values we popped for af
	ld	(_zxn_p3call_err), a
	ld	hl, $FFFF	; return -1
	ld	d, h		; even if it's a 32-bit return
	ld	e, l
	ret			; return to retaddr
