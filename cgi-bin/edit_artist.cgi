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

my $nick = $cgi->param( 'artistNick' );
my $born = $cgi->param( 'artistBorn' );
my $death = $cgi->param( 'artistDeath' );
my $description = $cgi->param( 'artistDescription' );

my $id = $nick;
$id =~ s/\s+//g;
$id = lc $id;

my $file = '../data/database/artistlist.xml';

my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my $framment = 
    "<artist id='$id' >
       <nick>$nick</nick>
       <born>$born</born>";

if( $death )
{
    $framment = $framment . "<death>$death</death>";
}

$framment = $framment . "<description>$description</description></artist>";

my $artist = $parser->parse_balanced_chunk( $framment ) || die( 'Frammento non ben formato' );
my $root = $doc->findnodes( 'xs:artistList' )->get_node( 1 );

$root->appendChild( $artist ) || die( 'Non appeso' );

open( OUT, ">$file" );
print OUT $doc->toString;
close( OUT );

print "Write all";

