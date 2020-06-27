CC = zcc +zxn -SO3 -clib=sdcc_iy
# CC = zcc +zxn -O3 -clib=new

OBJS = zxn_p3call.o zxn_p3call_error.o zxn_p3call_results.o zxn_p3cont_a.o zxn_p3cont_a_err.o zxn_p3cont_bc.o zxn_p3cont_bc_err.o zxn_p3cont_de_err.o zxn_p3cont_dehl.o zxn_p3cont_dehl_err.o zxn_p3cont_e.o zxn_p3cont_e_err.o zxn_p3cont_err.o zxn_p3cont_generic.o zxn_p3cont_hl.o zxn_p3cont_hl_err.o zxn_p3cont_ix.o zxn_p3cont_ix_err.o zxn_p3cont_null.o

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
zxn_p3call_error.o: zxn_p3call_error.c zxn_p3call_private.h zxn_p3call.h
zxn_p3call_results.o: zxn_p3call_results.c zxn_p3call_private.h \
 zxn_p3call.h
zxn_p3cont_a.o: zxn_p3cont_a.c zxn_p3call_private.h zxn_p3call.h
zxn_p3cont_a_err.o: zxn_p3cont_a_err.c zxn_p3call_private.h zxn_p3call.h
zxn_p3cont_bc.o: zxn_p3cont_bc.c zxn_p3call_private.h zxn_p3call.h
zxn_p3cont_bc_err.o: zxn_p3cont_bc_err.c zxn_p3call_private.h \
 zxn_p3call.h
zxn_p3cont_de_err.o: zxn_p3cont_de_err.c zxn_p3call_private.h \
 zxn_p3call.h
zxn_p3cont_dehl.o: zxn_p3cont_dehl.c zxn_p3call_private.h zxn_p3call.h
zxn_p3cont_dehl_err.o: zxn_p3cont_dehl_err.c zxn_p3call_private.h \
 zxn_p3call.h
zxn_p3cont_e.o: zxn_p3cont_e.c zxn_p3call_private.h zxn_p3call.h
zxn_p3cont_e_err.o: zxn_p3cont_e_err.c zxn_p3call_private.h zxn_p3call.h
zxn_p3cont_err.o: zxn_p3cont_err.c zxn_p3call_private.h zxn_p3call.h
zxn_p3cont_generic.o: zxn_p3cont_generic.c zxn_p3call_private.h \
 zxn_p3call.h
zxn_p3cont_hl.o: zxn_p3cont_hl.c zxn_p3call_private.h zxn_p3call.h
zxn_p3cont_hl_err.o: zxn_p3cont_hl_err.c zxn_p3call_private.h \
 zxn_p3call.h
zxn_p3cont_ix.o: zxn_p3cont_ix.c zxn_p3call_private.h zxn_p3call.h
zxn_p3cont_ix_err.o: zxn_p3cont_ix_err.c zxn_p3call_private.h \
 zxn_p3call.h
zxn_p3cont_null.o: zxn_p3cont_null.c zxn_p3call_private.h zxn_p3call.h
