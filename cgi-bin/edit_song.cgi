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

print $cgi->redirect( "r.cgi?section=artist&amp;id=$artist&amp;mode=edit" );

