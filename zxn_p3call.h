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

/* The "continuation function" provided to zxn_p3call is passed all the
 * registers resulting from the call, and chooses what to return.
 * Multiple predefined continuation functions are provided, but you
 * are free to write your own.  It *must* have the following signature.
 *
 * The predefined ones are explicitly coded in assembler and should not
 * be called directly as they expect a specific stack configuration.
 */

#define zxn_p3call_define_cont(name)				\
    short name(short af, short bc, short de, short hl,		\
		       short ix) __smallc

zxn_p3call_define_cont(zxn_p3cont_a);
zxn_p3call_define_cont(zxn_p3cont_a_err);
zxn_p3call_define_cont(zxn_p3cont_af);
zxn_p3call_define_cont(zxn_p3cont_af_err);
zxn_p3call_define_cont(zxn_p3cont_aliases);
zxn_p3call_define_cont(zxn_p3cont_aliases_err);
zxn_p3call_define_cont(zxn_p3cont_b);
zxn_p3call_define_cont(zxn_p3cont_b_err);
zxn_p3call_define_cont(zxn_p3cont_bc);
zxn_p3call_define_cont(zxn_p3cont_bc_err);
zxn_p3call_define_cont(zxn_p3cont_bcde);
zxn_p3call_define_cont(zxn_p3cont_bcde_err);
zxn_p3call_define_cont(zxn_p3cont_c);
zxn_p3call_define_cont(zxn_p3cont_c_err);
zxn_p3call_define_cont(zxn_p3cont_d);
zxn_p3call_define_cont(zxn_p3cont_d_err);
zxn_p3call_define_cont(zxn_p3cont_de);
zxn_p3call_define_cont(zxn_p3cont_de_err);
zxn_p3call_define_cont(zxn_p3cont_dehl);
zxn_p3call_define_cont(zxn_p3cont_dehl_err);
zxn_p3call_define_cont(zxn_p3cont_e);
zxn_p3call_define_cont(zxn_p3cont_e_err);
zxn_p3call_define_cont(zxn_p3cont_errcheck);
zxn_p3call_define_cont(zxn_p3cont_errcheck_err);
zxn_p3call_define_cont(zxn_p3cont_f);
zxn_p3call_define_cont(zxn_p3cont_f_err);
zxn_p3call_define_cont(zxn_p3cont_h);
zxn_p3call_define_cont(zxn_p3cont_h_err);
zxn_p3call_define_cont(zxn_p3cont_hl);
zxn_p3call_define_cont(zxn_p3cont_hl_err);
zxn_p3call_define_cont(zxn_p3cont_ix);
zxn_p3call_define_cont(zxn_p3cont_ix_err);
zxn_p3call_define_cont(zxn_p3cont_l);
zxn_p3call_define_cont(zxn_p3cont_l_err);
zxn_p3call_define_cont(zxn_p3cont_null);
zxn_p3call_define_cont(zxn_p3cont_err);
zxn_p3call_define_cont(zxn_p3cont_generic);

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
