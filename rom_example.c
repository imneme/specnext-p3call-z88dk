#include <stdio.h>
#include <stdlib.h>
#include <zxn_rom3call.h>

static short window_handle;

#define SYSVAR_CURCHL ((short*) 0x5C51)

static char buffer[256] = "Sausages";

int main()
{
//    zxn_rom3_plot_sub(50,50);
    zxn_rom3call(zxn_p3cont_null, ZXN_ROM3_PLOT_SUB, 0, \
                 0x4200, 0x1234, 0x2345, 0x3456, 0x4567);
    printf("Hello World\n");
    return 0;
}

