#include <stdio.h>
#include <stdlib.h>
#include <zxn_p3call.h>

static short window_handle;

#define SYSVAR_CURCHL ((short*) 0x5C51)

static char buffer[256] = "Sausages";

int main()
{
    short orig_handle;
    short count = 8;
    if (zxn_ide_mode_set(1,2)) {
	printf("Mode set failed!");
	exit(1);
    }
    window_handle = zxn_p3call_results.ix;
    printf("Mode has %d lines and %d cols\n", zxn_p3call_results.hl >> 8, 
	   zxn_p3call_results.hl & 0xff);    
    printf("Integer variable Z = %d\n", zxn_ide_integer_var('Z',0,0));
    zxn_ide_integer_var('X',1,42);
    printf("Integer variable X set to 42\n");

    orig_handle = *SYSVAR_CURCHL;
    *SYSVAR_CURCHL = window_handle;
    zxn_ide_window_string("Hello World\r", 12);
    *SYSVAR_CURCHL = orig_handle;
    
    return 0;
}

