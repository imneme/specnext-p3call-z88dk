CC = zcc +zxn -SO3 -clib=sdcc_iy
# CC = zcc +zxn -O3 -clib=new

OBJS = zxn_p3call.o zxn_p3cont_aliases.o zxn_p3cont_a.o			\
    zxn_p3cont_af.o zxn_p3cont_b.o zxn_p3cont_bc.o zxn_p3cont_bcde.o	\
    zxn_p3cont_c.o zxn_p3cont_d.o zxn_p3cont_de.o zxn_p3cont_dehl.o	\
    zxn_p3cont_e.o zxn_p3cont_errcheck.o zxn_p3cont_f.o zxn_p3cont_h.o	\
    zxn_p3cont_ix.o zxn_p3cont_l.o zxn_p3cont_generic.o			\
    zxn_rom3call.o

TARGETS = zxn_p3call.lib example.tap rom3_example.tap

all: $(TARGETS)

clean:
	rm -f $(TARGETS) $(OBJS)

example.tap: example.c zxn_p3call.h
	$(CC) $< -o example -I. -lzxn_p3call -startup=30 -create-app

example.bas: example.bastxt
	txt2bas -f 3dos -i $< -o $@

rom3_example.tap: rom_example.c zxn_rom3call.h
	$(CC) $< -o rom_example -I. -lzxn_p3call -startup=30 -create-app

zxn_p3call.lib: $(OBJS)
	z80asm --make-lib=$@ $^

zxn_rom3call.o: zxn_rom3call.asm
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
zxn_p3cont_ix.o: zxn_p3cont_ix.asm
zxn_p3cont_l.o: zxn_p3cont_l.asm
zxn_p3cont_generic.o: zxn_p3cont_generic.asm
