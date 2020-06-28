;;; This code was generated by a script

	SECTION code_compiler
	GLOBAL  _zxn_p3cont_bc
	GLOBAL  _zxn_p3cont_bc_err
	GLOBAL  zxn_p3cont_errcheck

;;; On entry, stack holds
;;;     retaddr, af, bc, de, hl, ix, zxn_p3call_adjstack

_zxn_p3cont_bc_err:
	call	zxn_p3cont_errcheck	; might not return
_zxn_p3cont_bc:
	pop     af		; throw away zxn_p3call_adjstack, not needed
				; (only used if user writes a custom handler)
	pop	af		; pop value for ix (ignored)
	pop	af		; pop value for hl (ignored)
	pop	af		; pop value for de (ignored)
	pop	hl		; pop value for bc (to return)
	pop	af		; pop value for af (ignored)
	ret			; done
