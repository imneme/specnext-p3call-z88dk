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

#define ZXN_ROM3_PRINT_A_1  0x0010    // print char to current stream

#define ZXN_ROM3_BC_SPACES  0x0030    // allocate workspace

#define ZXN_ROM3_BEEPER     0x03b5    // make a sound using the beeper

#define zxn_rom3_beeper(freqtime, tstates)			\
    zxn_rom3call(zxn_p3cont_null, ZXN_ROM3_BEEPER, 0,		\
                 0, 0, freqtime, tstates, 0)

#define ZXN_ROM3_SV_BYTES   0x04c2    // save bytes to tape

#define zxn_rom3_sv_bytes(type, length, start)		\
    zxn_rom3call(zxn_p3cont_null, ZXN_ROM3_SV_BYTES, 0,	\
                 (type << 8), 0, length, 0, start)

#define ZXN_ROM3_LD_BYTES   0x0556    // load/verify bytes from tape

#define zxn_rom3_ld_bytes(type, loadNotVerify, length, start)		\
    zxn_rom3call(zxn_p3cont_null, ZXN_ROM3_LD_BYTES, 0,			\
                 (type << 8) | loadNotVerify, 0, length, 0, start)

#define ZXN_ROM3_CLS        0x0d6b    // CLS (for layer 0)

#define zxn_rom3_cls()					\
    zxn_rom3call(zxn_p3cont_null, ZXN_ROM3_CLS, 0,	\
		 0, 0, 0, 0, 0)

#define ZXN_ROM3_PRINT_A_2  0x15f2    // print char to current stream

#define ZXN_ROM3_CALL_SUB   0x15f7    // execute routine at (HL') (trashes DE')

#define ZXN_ROM3_CHAN_OPEN  0x1601    // open channel to stream

#define ZXN_ROM3_CALL_JUMP  0x162c    // execute routine at HL

#define ZXN_ROM3_CLASS_01   0x1c1f    // class 01, variable to assign

#define ZXN_ROM3_OUT_SP_NO  0x192a    // print a digit helper (E=' ' or $FF)

#define ZXN_ROM3_RECLAIM_2  0x19e8    // reclaim BC bytes at HL

#define ZXN_ROM3_OUT_NUM_3  0x1a1B    // print a num (<9999) from HL, (E=...)

#define ZXN_ROM3_TEST_ROOM  0x1f05    // check for free mem in basic workspace

#define zxn_rom3_test_room(space)			\
    zxn_rom3call(zxn_p3cont_hl, ZXN_ROM3_TEST_ROOM, 0,	\
		 0, space, 0, 0, 0)

#define ZXN_ROM3_PR_STRING  0x203c    // print string DE,BC

#define ZXN_ROM3_PLOT_SUB   0x22e5    // plot a point

#define zxn_rom3_plot_sub(x,y)				\
    zxn_rom3call(zxn_p3cont_null, ZXN_ROM3_PLOT_SUB, 0,	\
		 0, (y << 8) | x, 0, 0, 0)


#define ZXN_ROM3_STK_STO_S  0x2ab2    // store string on calc stack

#define ZXN_ROM3_LET        0x2aff    // LET

#define ZXN_ROM3_PRINT_FP   0x2de3    // print floating point from calc stack

#define ZXN_ROM3_STACK_A    0x2d28    // push A to calculator stack


#endif /* ZXN_ROM3CALL_H_INCLUDED */
