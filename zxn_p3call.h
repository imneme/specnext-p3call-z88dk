#ifndef ZXN_P3CALL_H_INCLUDED
#define ZXN_P3CALL_H_INCLUDED 1

extern short zxn_p3call(void* cont, short callno, short himem, 
			short a, short bc, short de, short hl, 
			short ix) __smallc __z88dk_callee;

extern long zxn_p3call_long(void* cont, short callno, short himem, 
			    short a, short bc, short de, short hl, 
			    short ix) __smallc __z88dk_callee;

struct zxn_ide_regset {
    char f;
    char a;
    short bc;
    short de;
    short hl;
    short ix;
};

short zxn_p3cont_a(short af, short bc, short de, short hl,
		   short ix) __smallc;

short zxn_p3cont_a_err(short af, short bc, short de, short hl,
		       short ix) __smallc;

short zxn_p3cont_bc(short af, short bc, short de, short hl,
		    short ix) __smallc;

short zxn_p3cont_bc_err(short af, short bc, short de, short hl,
			short ix) __smallc;

short zxn_p3cont_de_err(short af, short bc, short de, short hl,
			short ix) __smallc;

long zxn_p3cont_dehl(short af, short bc, short de, short hl,
		     short ix) __smallc;

long zxn_p3cont_dehl_err(short af, short bc, short de, short hl,
			 short ix) __smallc;

short zxn_p3cont_e(short af, short bc, short de, short hl,
		   short ix) __smallc;

short zxn_p3cont_e_err(short af, short bc, short de, short hl,
		       short ix) __smallc;

short zxn_p3cont_err(short af, short bc, short de, short hl,
		  short ix) __smallc;

short zxn_p3cont_generic(short af, short bc, short de, short hl,
			 short ix) __smallc;

short zxn_p3cont_hl(short af, short bc, short de, short hl,
		    short ix) __smallc;

short zxn_p3cont_hl_err(short af, short bc, short de, short hl,
			short ix) __smallc;

short zxn_p3cont_ix(short af, short bc, short de, short hl,
		    short ix) __smallc;

short zxn_p3cont_ix_err(short af, short bc, short de, short hl,
			short ix) __smallc;

short zxn_p3cont_null(short af, short bc, short de, short hl,
		      short ix) __smallc;

extern struct zxn_ide_regset zxn_p3call_results;

extern char zxn_p3call_err;

#define zxn_ide_integer_var(v,rw,val)				\
    zxn_p3call(zxn_p3cont_de_err, 0x01c9, 7,		\
	       0, v - 'A', val, rw ? 0x0100 : 0x0000, 0)

#define zxn_ide_mode_set(mode,submode)		\
    zxn_p3call(zxn_p3cont_generic, 0x01d5, 7,	\
	       0x0100, (mode << 8) | submode, 0, 0, 0)

#define zxn_ide_window_string(lowaddr, nchars)	\
    zxn_p3call(zxn_p3cont_null, 0x01c6, 7,	\
	       0, 0, nchars, (short) lowaddr, 0)

#define zxn_ide_window_linein(lowaddr, bsize, nchars)	 \
    zxn_p3call(zxn_p3cont_e, 0x01c3, 7,		 \
               (bsize) << 8, 0, nchars, (short) lowaddr, 0)

#define zxn_ide_tokenizer(detok, bank, bankoffset)	   \
    zxn_p3call(zxn_p3cont_generic, 0x01d8, 7,              \
               0, ((detok) << 8) | bank , 0, bankoffset, 0)

#endif /* ZXN_P3CALL_H_INCLUDED */
