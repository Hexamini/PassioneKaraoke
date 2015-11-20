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

my $cgi = new CGI;
print $cgi->header();

my $output = '';

my $tt = Template->new({
    RELATIVE => 1,
    INCLUDE_PATH => "../data/views",
    OUTPUT => \$output,
});

my $values = {
    nome => 'Andrea',
    cognome => 'Mantovani',
    data => '17 settembre 1994',
    numero => '+393406936174',
};

$tt->process( 'table.html', $values ) || die $tt->error();
#print redirect( -url => '../public_html/table.html' );
print $output . "\n";

