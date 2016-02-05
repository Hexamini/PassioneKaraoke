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

#Rimozione dalla tabella artistlist

my $doc = ParserXML::getDoc( $parser, $file );

my $album = $doc->findnodes( "//xs:artist[\@id='$idArtist']/xs:album[\@id='$idAlbum']")->get_node( 1 );
my $root = $album->parentNode;

$root->removeChild( $album );

open( OUT, ">$file");
print OUT $doc->toString;
close( OUT );

#Rimozione dalla tabella news

$file = '../data/database/news.xml';
$doc = ParserXML::getDoc( $parser, $file );

my @news = $doc->findnodes( "//xs:newSong[\@artist='$idArtist' and \@album='$idAlbum']" );
my $root = '';

if ( scalar @news > 0 ) {
    #Cancella ogni notizia riguardante l'album di un'artista
    foreach my $newsSong( @news ) {
	$root = $newsSong->parentNode;
	$root->removeChild( $newsSong );
    }

    open( OUT, ">$file" );
    print OUT $doc->toString;
    close( OUT );
}

#Rimozione dalla tabella userlist

$file = '../data/database/userlist.xml';
$doc = ParserXML::getDoc( $parser, $file );

my @typeVotes = $doc->findnodes( "//xs:typeVote[\@idArtist='$idArtist' and \@idAlbum='$idAlbum']" );
my $root = '';

if ( scalar @typeVotes > 0 ) {
    #Cancella ogni preferenza dell'utente rigurdante canzoni dell'album
    foreach my $typeVote( @typeVotes ) {
	$root = $typeVote->parentNode;
	$root->removeChild( $typeVote );
    }

    open( OUT, ">$file" );
    print OUT $doc->toString;
    close( OUT );
}

print $cgi->redirect( "r.cgi?section=artist&id=$idArtist&mode=edit" );
