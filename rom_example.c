#include <stdio.h>
#include <stdlib.h>
#include <zxn_rom3call.h>

static short window_handle;

#define SYSVAR_CURCHL ((short*) 0x5C51)

static char buffer[256] = "Sausages";

int main()
{
    int i;
    printf("Hello World\n");
    for (i = 0; i < 256; ++i)
	zxn_rom3_plot_sub(i,i/2);
    zxn_rom3_beeper(0x0085, 0x066a);
    return 0;
}

