#ifndef ZXN_ROM3CALL_H_INCLUDED
#define ZXN_RPM3CALL_H_INCLUDED 1

#include <zxn_p3call.h>

extern short zxn_rom3call(void* cont, short callno, short hlprime, 
			short a, short bc, short de, short hl, 
			short ix) __smallc __z88dk_callee;

extern long zxn_rom3call_long(void* cont, short callno, short hlprime, 
			    short a, short bc, short de, short hl, 
			    short ix) __smallc __z88dk_callee;

/* The p3call "continuation functions" also work for rom3call, as the
 * same registers are returned.
 */

#define ZXN_ROM3_PLOT_SUB 0x22E5

#define zxn_rom3_plot_sub(x,y)				\
    zxn_rom3call(zxn_p3cont_null, ZXN_ROM3_PLOT_SUB, 0,	\
		 0, (x << 8) | y, 0, 0, 0)


#endif /* ZXN_ROM3CALL_H_INCLUDED */
