#!/usr/bin/perl
use lib "cgi-bin"; #miei packages

use Object::Table;

print Table::getHTML( "Andrea", 
		      "Mantovani", 
		      "17 settembre 1994", 
		      "+39 3466936174");
exit;
