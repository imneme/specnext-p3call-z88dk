#include "zxn_p3call_private.h"

short zxn_p3cont_generic(short af, short bc, short de, short hl,
			 short ix) __smallc
{
    zxn_p3call_results.ix = ix;
    zxn_p3call_results.hl = hl;
    zxn_p3call_results.de = de;
    zxn_p3call_results.bc = bc;
    zxn_p3call_results.a = af >> 8;
    zxn_p3call_results.f = af & 0xff;
    iferror {
	return 0;
    } else {
	return -1;
    }
}

