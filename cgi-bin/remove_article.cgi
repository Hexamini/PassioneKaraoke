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

my $id = $cgi->param( 'args' );
my $file = '../data/database/articlelist.xml';

my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my $article = $doc->findnodes( "//xs:article[\@id='$id']" )->get_node( 1 );
my $root = $article->parentNode;

$root->removeChild( $article );

open( OUT, ">$file" );
print OUT $doc->toString;
close( OUT );

print $cgi->redirect( -uri => 'r.cgi?section=articles&mode=edit' );

		

		

