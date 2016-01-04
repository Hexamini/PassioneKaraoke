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

my $id = $cgi->param( 'idArtist' );
my $nick = $cgi->param( 'nickArtist' );
my $born = $cgi->param( 'bornArtist' );
my $death = $cgi->param( 'deathArtist' );
my $description = $cgi->param( 'descriptionArtist' );

my $file = '../data/database/artistlist.xml';

my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my $artist = $doc->findnodes( "\\xs:artist[\@id='$id']" );

if( $nick )
{
    my $nodeNick = $artist->( 'xs:nick\text()' )->get_node( 1 );
    $nodeNick->setData( $nick );
}
