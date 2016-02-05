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

my $user = $cgi->param( 'user' );
my $artist = $cgi->param( 'artist' );
my $album = $cgi->param( 'album' );
my $song = $cgi->param( 'song' );
my $vote = $cgi->param( 'like' );

my $file = '../data/database/userlist.xml';
my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my $framment = 
   "<typeVote idSong='$song' idArtist='$artist' idAlbum='$album'>$vote</typeVote>";

my $votes = $parser->parse_balanced_chunk( $framment ) || die( 'Frammento non ben formato' );
my $root = $doc->findnodes( "//xs:user[\@username='$user']/xs:votes" )->get_node( 1 );

$root->appendChild( $votes ) || die( 'Non appeso' );

open( OUT, ">$file" );
print OUT $doc->toString;
close( OUT );

print $cgi->redirect( 
      "r.cgi?section=songDescription&artist=$artist".
      "&album=$album&song=$song" 
);



