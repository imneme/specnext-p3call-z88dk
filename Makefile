CC = zcc +zxn -SO3 -clib=sdcc_iy
# CC = zcc +zxn -O3 -clib=new

OBJS = zxn_p3call.o zxn_p3cont_aliases.o zxn_p3cont_a.o zxn_p3cont_af.o zxn_p3cont_b.o zxn_p3cont_bc.o zxn_p3cont_bcde.o zxn_p3cont_c.o zxn_p3cont_d.o zxn_p3cont_de.o zxn_p3cont_dehl.o zxn_p3cont_e.o zxn_p3cont_errcheck.o zxn_p3cont_f.o zxn_p3cont_h.o zxn_p3cont_hl.o zxn_p3cont_ix.o zxn_p3cont_l.o zxn_p3cont_generic.o zxn_p3call_error.o zxn_p3call_results.o

TARGETS = zxn_p3call.lib example.tap

all: $(TARGETS)

clean:
	rm -f $(TARGETS) $(OBJS)

example.tap: example.c
	$(CC) $< -o example -I. -lzxn_p3call -startup=30 -create-app

example.bas: example.bastxt
	txt2bas -f 3dos -i $< -o $@

zxn_p3call.lib: $(OBJS)
	z80asm --make-lib=$@ $^

zxn_p3call.o: zxn_p3call.asm
zxn_p3cont_aliases.o: zxn_p3cont_aliases.asm
zxn_p3cont_a.o: zxn_p3cont_a.asm
zxn_p3cont_af.o: zxn_p3cont_af.asm
zxn_p3cont_b.o: zxn_p3cont_b.asm
zxn_p3cont_bc.o: zxn_p3cont_bc.asm
zxn_p3cont_bcde.o: zxn_p3cont_bcde.asm
zxn_p3cont_c.o: zxn_p3cont_c.asm
zxn_p3cont_d.o: zxn_p3cont_d.asm
zxn_p3cont_de.o: zxn_p3cont_de.asm
zxn_p3cont_dehl.o: zxn_p3cont_dehl.asm
zxn_p3cont_e.o: zxn_p3cont_e.asm
zxn_p3cont_e.c.o: zxn_p3cont_e.c.asm
zxn_p3cont_errcheck.o: zxn_p3cont_errcheck.asm
zxn_p3cont_f.o: zxn_p3cont_f.asm
zxn_p3cont_h.o: zxn_p3cont_h.asm
zxn_p3cont_hl.o: zxn_p3cont_hl.asm
zxn_p3cont_ix.o: zxn_p3cont_ix.asm
zxn_p3cont_l.o: zxn_p3cont_l.asm

zxn_p3call_error.o: zxn_p3call_error.c zxn_p3call_private.h zxn_p3call.h
zxn_p3call_results.o: zxn_p3call_results.c zxn_p3call_private.h \
 zxn_p3call.h
# zxn_p3cont_a.o: zxn_p3cont_a.c zxn_p3call_private.h zxn_p3call.h
# zxn_p3cont_a_err.o: zxn_p3cont_a_err.c zxn_p3call_private.h zxn_p3call.h
# zxn_p3cont_bc.o: zxn_p3cont_bc.c zxn_p3call_private.h zxn_p3call.h
# zxn_p3cont_bc_err.o: zxn_p3cont_bc_err.c zxn_p3call_private.h \
#  zxn_p3call.h
# zxn_p3cont_de_err.o: zxn_p3cont_de_err.c zxn_p3call_private.h \
#  zxn_p3call.h
# zxn_p3cont_dehl.o: zxn_p3cont_dehl.c zxn_p3call_private.h zxn_p3call.h
# zxn_p3cont_dehl_err.o: zxn_p3cont_dehl_err.c zxn_p3call_private.h \
#  zxn_p3call.h
# zxn_p3cont_e.o: zxn_p3cont_e.c zxn_p3call_private.h zxn_p3call.h
# zxn_p3cont_e_err.o: zxn_p3cont_e_err.c zxn_p3call_private.h zxn_p3call.h
# zxn_p3cont_err.o: zxn_p3cont_err.c zxn_p3call_private.h zxn_p3call.h
zxn_p3cont_generic.o: zxn_p3cont_generic.c zxn_p3call_private.h \
 zxn_p3call.h
# zxn_p3cont_hl.o: zxn_p3cont_hl.c zxn_p3call_private.h zxn_p3call.h
# zxn_p3cont_hl_err.o: zxn_p3cont_hl_err.c zxn_p3call_private.h \
#  zxn_p3call.h
# zxn_p3cont_ix.o: zxn_p3cont_ix.c zxn_p3call_private.h zxn_p3call.h
# zxn_p3cont_ix_err.o: zxn_p3cont_ix_err.c zxn_p3call_private.h \
#  zxn_p3call.h
# zxn_p3cont_null.o: zxn_p3cont_null.c zxn_p3call_private.h zxn_p3call.h
