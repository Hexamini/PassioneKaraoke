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

my $author = $cgi->param( 'artistName' );
my $name = $cgi->param( 'albumName' );
my $creation = $cgi->param( 'albumCreation' );

my $file = '../data/database/artistlist.xml';

my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my $id = '_' . $name;
$id =~ s/\s+//g;
$id = lc $id;

my $framment = 
    "<album id='$id'>
       <name>$name</name>
       <creation>$creation</creation>
     </album>";

my $album = $parser->parse_balanced_chunk( $framment ) || die( 'Frammento non ben formato' );
my $root = $doc->findnodes( "//xs:artist[\@id='$author']" )->get_node( 1 );

$root->appendChild( $album ) || die( 'Non appeso' );

open( OUT, ">$file" );
print OUT $doc->toString;
close( OUT );

print "Write all";




