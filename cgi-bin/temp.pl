#!/usr/bin/perl -w
use Template;
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
use lib "cgi-bin";

use Object::Utility::ParserHTML;
use Object::Table;

my $cgi = new CGI;
print $cgi->header();

my $table = Table::getHTML({ 	
    nome => 'Andrea',
    cognome => 'Mantovani',
    data => '17 settembre 1994',
    numero => '+393406936174',
			   });

my $table1 = Table::getHTML({ 	
    nome => 'Andrea',
    cognome => 'Mantovani',
    data => '17 settembre 1994',
    numero => '+393406936174',
			   });


print "$table<br>$table1\n";

