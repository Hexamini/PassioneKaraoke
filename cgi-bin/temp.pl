#!/usr/bin/perl -w
use Template;
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
use lib "cgi-bin";

use Object::Table;
use Object::Page;

my $tt = Template->new({
	RELATIVE => 1,
    INCLUDE_PATH => "../data/view",
    OUTPUT_PATH  => "../public_html",
});

my $values = {
    nome => 'Andrea',
    cognome => 'Mantovani',
    data => '17 settembre 1994',
    numero => '+393406936174',
};

$tt->process( 'table.html', $values, 'table.html' ) || die $tt->error();
print redirect( -url => '../public_html/table.html' );

