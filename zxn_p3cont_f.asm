;;; This code was generated by a script

	SECTION code_compiler
	GLOBAL  _zxn_p3cont_f
	GLOBAL  _zxn_p3cont_f_err
	GLOBAL  zxn_p3cont_errcheck

;;; On entry, stack holds
;;;     retaddr, af, bc, de, hl, ix, zxn_p3call_adjstack

_zxn_p3cont_f_err:
	call	zxn_p3cont_errcheck	; might not return
_zxn_p3cont_f:
	pop     hl		; throw away zxn_p3call_adjstack, not needed
				; (only used if user writes a custom handler)
	pop	hl		; pop value for ix (ignored)
	pop	hl		; pop value for hl (ignored)
	pop	hl		; pop value for de (ignored)
	pop	hl		; pop value for bc (ignored)
	pop	hl		; pop value for af (to return)
	ld	h, 0		; clear high bits of result
	ret			; done
