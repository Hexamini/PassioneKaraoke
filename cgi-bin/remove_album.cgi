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

my $args = $cgi->param( 'args' );

my ( $idArtist, $idAlbum ) = split /:/, $args;

my $file = '../data/database/artistlist.xml';

my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my $album = $doc->findnodes( "//xs:artist[\@id='$idArtist']/xs:album[\@id='$idAlbum']")->get_node( 1 );
my $root = $album->parentNode;

$root->removeChild( $album );

open( OUT, ">$file");
print OUT $doc->toString;
close( OUT );

print $cgi->redirect( "r.cgi?section=artist&id=$idArtist&mode=edit" );
