;;; This code was generated by a script

        SECTION code_compiler
        GLOBAL  _zxn_p3cont_e
        GLOBAL  _zxn_p3cont_e_err
	GLOBAL  zxn_p3cont_errcheck

;;; On entry, stack holds
;;;     retaddr, af, bc, de, hl, ix, zxn_p3call_adjstack

_zxn_p3cont_e_err:
        call	zxn_p3cont_errcheck	; either won't return or pops adjstack
_zxn_p3cont_e:
	pop	af		; pop value for ix (ignored)
	pop	af		; pop value for hl (ignored)
	pop	hl		; pop value for de (to return)
	ld	h, 0		; clear high bits of result
	pop	af		; pop value for bc (ignored)
	pop	af		; pop value for af (ignored)
	ret			; done