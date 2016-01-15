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

my $name = $cgi->param( 'songTitle' );
my $artist = $cgi->param( 'songArtist' );
my $album = $cgi->param( 'songAlbum' );
my $lyrics = $cgi->param( 'songLyrics' );
my $extra = $cgi->param( 'songExtra' );
my $category = $cgi->param( 'songCategory' );

my $id = '_' . $name;
$id =~ s/\s+//g;
$id = lc $id;

#Sezione aggiunta canzoni nel database
my $framment = 
    "<song id='$id'>
       <name>$name</name>
       <lyrics>$lyrics</lyrics>
       <extra>$extra</extra>
       <category>$category</category>
       <grades>0</grades>
     </song>";

my $file = '../data/database/artistlist.xml';
my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my $song = $parser->parse_balanced_chunk( $framment ) || die( 'Frammento non ben formato' );
my $root = $doc->findnodes( "/xs:artistList/xs:artist[\@id='$artist']/xs:album[\@id='$album']" )->get_node( 1 );

$root->appendChild( $song ) || die( 'Non appeso' );

open( OUT, ">$file" );
print OUT $doc->toString;
close( OUT );

#Sezione per l'aggiornamento dell'ultima canzone
$file = '../data/database/news.xml';
$doc = ParserXML::getDoc( $parser, $file );

$framment = "<newSong id='$id' artist='$artist' album='$album'>$name</newSong>";

my $newSong = $parser->parse_balanced_chunk( $framment ) || die( 'Frammento non ben formato' );

$root = $doc->findnodes( '//xs:songs' );
my $size = $root->size();

$root = $root->get_node( 1 );

if ( $size == 5 ) {
    my $oldNode = $root->findnodes( 'newSong[1]' )->get_node( 1 );
    $root->removeChild( $oldNode );
}    

$root->appendChild( $newSong ) || die( 'Non appeso' );

open( OUT, ">$file" );
print OUT $doc->toString;
close( OUT );

print $cgi->redirect( "r.cgi?section=artist&amp;id=$artist&amp;mode=edit" );

