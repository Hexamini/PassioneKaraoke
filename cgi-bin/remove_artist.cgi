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

my $id = $cgi->param( 'args' );
my $parser = XML::LibXML->new();

#Cancella ogni notizia riguardante quell'artista

my $file = '../data/database/news.xml';
my $doc = ParserXML::getDoc( $parser, $file );

my @news = $doc->findnodes( "//xs:newSong[\@artist='$id']" );
my $root = $doc->findnodes( "//xs:songs" )->get_node( 1 );

print scalar @news;

foreach my $newsSong( @news ) {
    $root->removeChild( $newsSong );
}

open( OUT, ">$file" );
print $doc->toString;
close( OUT );

#Cancello l'artista

my $file = '../data/database/artistlist.xml';
my $doc = ParserXML::getDoc( $parser, $file );

my $artist = $doc->findnodes( "//xs:artist[\@id='$id']" )->get_node( 1 );
my $root = $artist->parentNode;

$root->removeChild( $artist );

open( OUT, ">$file" );
print OUT $doc->toString;
close( OUT );

print $cgi->redirect( -uri => 'r.cgi?section=artists&mode=edit' );

