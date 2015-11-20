#!/usr/bin/perl -w
use Template;
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
use lib "cgi-bin";

use Object::Utility::ParserHTML;

my $cgi = new CGI;
print $cgi->header();

    my $values = {
	nome => 'Andrea',
	cognome => 'Mantovani',
	data => '17 settembre 1994',
	numero => '+393406936174',
    };


my $object = ParserHTML::parsing( { filename => 'table.html', values => $values, } );
print $object . "\n";

