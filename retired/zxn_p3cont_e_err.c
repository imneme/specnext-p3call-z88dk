#include "zxn_p3call_private.h"

short zxn_p3cont_e_err(short af, short bc, short de, short hl,
		       short ix) __smallc
{
    iferror {
	zxn_p3call_err = 0;
	return de & 0xff;
    } else {
	zxn_p3call_err = af >> 8;
	return -1;
    }
}

