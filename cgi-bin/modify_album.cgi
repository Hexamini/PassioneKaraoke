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

my $idArtist = $cgi->param( 'idArtist' );
my $idAlbum = $cgi->param( 'idAlbum' );
my $name = $cgi->param( 'nameAlbum' );
my $creation = $cgi->param( 'creationAlbum' );

my $file = '../data/database/artistlist.xml';

my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my $album = $doc->findnodes( "\\xs:artist[\@id='$idArtist']\xs:album[\@id='$idAlbum']" );

if( $name )
{
    #Aggiorno l'id
    $idAlbum = '_' . $name;
    $idAlbum =~ s/\s+//g;
    $idAlbum = lc $idAlbum;

    $album->setAttribute( 'id', $idAlbum );
    
    my $nodeName = $album->( 'xs:name\text()' )->get_node( 1 );
    $nodeName->setData( $name );
}

if( $creation )
{
    my $nodeCreation = $album->( 'xs:creation\text()' )->get_node( 1 );
    $nodeCreation->setData( $creation );
}
