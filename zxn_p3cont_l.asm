;;; This code was generated by a script

        SECTION code_compiler
        GLOBAL  _zxn_p3cont_l
        GLOBAL  _zxn_p3cont_l_err
	GLOBAL  zxn_p3cont_errcheck

;;; On entry, stack holds
;;;     retaddr, af, bc, de, hl, ix, zxn_p3call_adjstack

_zxn_p3cont_l_err:
        call	zxn_p3cont_errcheck	; either won't return or pops adjstack
_zxn_p3cont_l:
	pop	af		; pop value for ix (ignored)
	pop	hl		; pop value for hl (to return)
	ld	h, 0		; clear high bits of result
	pop	af		; pop value for de (ignored)
	pop	af		; pop value for bc (ignored)
	pop	af		; pop value for af (ignored)
	ret			; done
