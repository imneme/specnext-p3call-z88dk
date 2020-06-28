#!/usr/bin/perl -w

use strict;

@ARGV = qw(a b c d e f h l af bc de ix dehl bcde) unless @ARGV;

foreach my $reg (@ARGV) {
    $reg //= 'hl';
    $reg = lc($reg);

    $reg =~ m/^([afbcdehl]|af|bc|de|hl|ix|dehl|bcde)\z/
      or die "Unrecognized register ($reg)";

    my $filename = "zxn_p3cont_$reg.asm";
    open my $fh, '>', $filename or die "Can't open $filename! ($!)\n";
    printf STDERR "Writing $filename...\n";

    select $fh;
    my $name = "_zxn_p3cont_$reg";
    my $name_err = "_zxn_p3cont_${reg}_err";

    my $scratch = $reg =~ tr/af/af/ ? "hl" : "af";

    print <<"XXEOFXX";
;;; This code was generated by a script

	SECTION code_compiler
	GLOBAL  $name
	GLOBAL  $name_err
	GLOBAL  zxn_p3cont_errcheck

;;; On entry, stack holds
;;;     retaddr, af, bc, de, hl, ix, zxn_p3call_adjstack

$name_err:
	call	zxn_p3cont_errcheck	; might not return
$name:
	pop     $scratch		; throw away zxn_p3call_adjstack, not needed
				; (only used if user writes a custom handler)
XXEOFXX

    my $matcher;

    if ($reg eq "dehl") {
	$matcher = sub { s/^de/de/ or s/hl/hl/ };
    } elsif ($reg eq "bcde") {
	$matcher = sub { s/^bc/de/ or s/de/hl/ };
    } elsif ($reg eq "a") {
	$matcher = sub { s/^af/af/ };
    } else {
	$matcher = sub { s/^$reg\z/hl/
			   or s/^[abdh]$reg/hl/ && -1
			   or s/^$reg[fcel]/hl/ && 1 };
    }
    
    foreach my $stacked (qw(ix hl de bc af)) {
	local($_)   = $stacked;
	my $matched = $matcher->();
	my $popreg  = $matched ? $_ : $scratch;
	my $why     = $matched ? "to return" : "ignored";
	print "\tpop\t$popreg\t\t; pop value for $stacked ($why)\n";
	if ($matched && length $reg == 1) {
	    if ($matched > 0) {
		print "\tld\tl, ", substr($popreg,0,1), 
		  "\t\t; move to low bits of result\n";
	    }
	    print "\tld\th, 0\t\t; clear high bits of result\n";
	}
    }

    print "\tret\t\t\t; done\n";
}
