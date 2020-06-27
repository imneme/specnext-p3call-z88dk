#include "zxn_p3call_private.h"

short zxn_p3cont_a_err(short af, short bc, short de, short hl,
		       short ix) __smallc
{
    iferror {
	zxn_p3call_err = 0;
	return af >> 8;
    } else {
	zxn_p3call_err = af >> 8;
	return -1;
    }
}

