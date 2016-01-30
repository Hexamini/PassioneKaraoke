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

my ( $idArtist, $idAlbum, $idSong ) = split /:/, $cgi->param( 'args' );

my $file = '../data/database/artistlist.xml';

my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my $song = $doc->findnodes( "//xs:artist[\@id='$idArtist']/xs:album[\@id='$idAlbum']/xs:song[\@id='$idSong']")->get_node( 1 );
my $root = $song->parentNode;

$root->removeChild( $song );

open( OUT, ">$file" );
print OUT $doc->toString;
close( OUT );

print $cgi->redirect( -uri => "r.cgi?section=artist&id=$idArtist&mode=edit" );
