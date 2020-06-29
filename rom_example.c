#include <stdio.h>
#include <stdlib.h>
#include <zxn_rom3call.h>

void* get_sp(int i)
{
    return (void*) &i;
}

int main()
{
    int i;
    short free_mem;
    char key;
    char *cursor_pos;
    char *cp;
//  zxn_rom3_cls();
    zxn_rom3_chan_open(2);
    printf("Hello World\n");
    zxn_rom3_chan_open(1);
    zxn_rom3_pr_string("Hello World! ",12);
    zxn_rom3_chan_open(2);
    for (i = 0; i < 256; ++i)
	zxn_rom3_plot_sub(i,i/2);
    zxn_rom3_beeper(0x0085, 0x066a);

    zxn_rom3_chan_open(1);
    zxn_rom3_set_min();
    cursor_pos = (char*) zxn_rom3_bc_spaces(1);
    *cursor_pos = '\r';
    *((char*) 0x5C71) |= 0xa0;        // Set bits 7 and 5 of FLAGX
//  None of these lines are needed/helpful.
//  *((char*) 0x5c3c) |= 8;           // Set bit 3 of TV_FLAG
//  *((char*) 0x5C71) &= 0xbf;        // Clear bit 6 of FLAGX (not needed here)
//  *((char*) 0x5c3b) |= 0x0c;        // Set bits 2 and 3 of FLAGS (N/A)
    *((char**) 0x5C5B) = cursor_pos;  // Set K_CUR to cursor position.
    key = zxn_rom3_wait_key();
    zxn_rom3_chan_open(2);
    printf("You pressed '%c'\n", key);
    zxn_rom3_chan_open(1);
    zxn_rom3_pr_string(" | Prompt> ",11);
    zxn_rom3_editor();
    zxn_rom3_chan_open(2);
    cp = cursor_pos;
    while (*cp != '\r')
	++cp;
    *cp = '\0';
    printf("You entered: '%s'\n", cursor_pos);

    // This value is naccurate because the stack is moved above RAMTOP
    free_mem = 65535 - (unsigned short)zxn_rom3_test_room(0);
    // Correct it (assuming org 32768).
    free_mem -= ((unsigned short)get_sp(0)) - 32768;
    printf("%u bytes free for BASIC.\n", free_mem);
    return 0;
}

