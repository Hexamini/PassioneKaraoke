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

my $idArtist = $cgi->param( 'idArtits' );
my $idAlbum = $cgi->param( 'idAlbum' );
my $idSong = $cgi->param( 'idSong' );

my $file = '../data/database/artistlist.xml';

my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my $song = $doc->findnodes( "//xs:artist[\@id='$idArtist']/xs:album[\@id='$idAlbum']/xs:song[\@id='$idSong']")->get_node( 1 );
my $root = $song->parentNode;

$root->removeChild( $song );
