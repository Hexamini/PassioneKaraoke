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

my $idArtist = $cgi->param( 'artistName' );
my $idAlbum = $cgi->param( 'albumId' );
my $name = $cgi->param( 'albumName' );
my $creation = $cgi->param( 'albumCreation' );

my $file = '../data/database/artistlist.xml';

my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my $album = $doc->findnodes( "//xs:artist[\@id='$idArtist']/xs:album[\@id='$idAlbum']" )->get_node( 1 );

if( $name )
{
    #Aggiorno l'id
    $idAlbum = '_' . $name;
    $idAlbum =~ s/\s+//g;
    $idAlbum = lc $idAlbum;

    $album->setAttribute( 'id', $idAlbum );

    $album->removeChild( $album->findnodes( 'xs:name' )->get_node( 1 ) );

    my $name = $parser->parse_balanced_chunk( "<name><![CDATA[$name]]></name>" ) || die( 'Frammento non ben formato' );
    $album->appendChild( $name );
}

if( $creation )
{
    $album->removeChild( $album->findnodes( 'xs:creation' )->get_node( 1 ) );

    my $creation = $parser->parse_balanced_chunk( "<creation>$creation</creation>" ) || 
	die( 'Frammento non ben formato' );

    $album->appendChild( $creation );
}

open( OUT, ">$file" );
print OUT $doc->toString;
close( OUT );

print $cgi->redirect( -uri => "r.cgi?section=artist&id=$idArtist&mode=edit" );
