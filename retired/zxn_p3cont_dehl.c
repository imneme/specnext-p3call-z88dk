#include "zxn_p3call_private.h"

long zxn_p3cont_dehl(short af, short bc, short de, short hl,
		     short ix) __smallc
{
    return (((long)de) << 16) | hl;
}

