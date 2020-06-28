#include "zxn_p3call_private.h"

short zxn_p3cont_e(short af, short bc, short de, short hl,
		   short ix) __smallc
{
    return de & 0xff;
}

