#include "zxn_p3call_private.h"

short zxn_p3cont_err(short af, short bc, short de, short hl,
		  short ix) __smallc
{
    iferror {
	zxn_p3call_err = 0;
	return 0;
    } else {
	zxn_p3call_err = af >> 8;
	return zxn_p3call_err;
    }
}

