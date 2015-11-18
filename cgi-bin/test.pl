#!/usr/bin/perl
use lib "cgi-bin";

use Object::Table;
use Object::Page;

$table = Table::getHTML( "Andrea", 
			    "Mantovani", 
			    "17 settembre 1994", 
		            "+39 3466936174" );

print Page::getHTML( $table );
exit;
