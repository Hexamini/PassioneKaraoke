#!/usr/bin/perl -w
use lib "cgi-bin";
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
use XML::LibXML;

use Page::Object::Base::ParserXML;
    
my $cgi = new CGI;

print $cgi->header();

my $category = $cgi->param( 'categoryName' );

my $file = '../data/database/category.xml';

my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my $framment = "<category>$category</category>";

my $album = $parser->parse_balanced_chunk( $framment ) || die( 'Frammento non ben formato' );
my $root = $doc->findnodes( '/xs:categoryList' )->get_node( 1 );

$root->appendChild( $album ) || die( 'Non appeso' );

open( OUT, ">$file" );
print OUT $doc->toString;
close( OUT );

print "Write all";

