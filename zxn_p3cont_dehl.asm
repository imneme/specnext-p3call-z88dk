;;; This code was generated by a script

        SECTION code_compiler
        GLOBAL  _zxn_p3cont_dehl
        GLOBAL  _zxn_p3cont_dehl_err
	GLOBAL  zxn_p3cont_errcheck

;;; On entry, stack holds
;;;     retaddr, af, bc, de, hl, ix, zxn_p3call_adjstack

_zxn_p3cont_dehl_err:
        call	zxn_p3cont_errcheck	; either won't return or pops adjstack
_zxn_p3cont_dehl:
	pop	af		; pop value for ix (ignored)
	pop	hl		; pop value for hl (to return)
	pop	de		; pop value for de (to return)
	pop	af		; pop value for bc (ignored)
	pop	af		; pop value for af (ignored)
	ret			; done
