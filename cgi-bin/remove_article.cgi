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
my $fileArticle = '../data/database/articlelist.xml';

my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $fileArticle );

my $article = $doc->findnodes( "//xs:article[\@id='$id']" )->get_node( 1 );
my $root = $article->parentNode;

$root->removeChild( $article );

open( OUT, ">$fileArticle" );
print OUT $doc->toString;
close( OUT );

my $fileNews = '../data/database/news.xml';
$doc = ParserXML::getDoc( $parser, $fileNews );

my $news = $doc->findnodes( "//xs:newArticle[\@id='$id']" )->get_node( 1 );

if( $news ) {
    $root = $news->parentNode;
    $root->removeChild( $news );

    open( OUT, ">$fileNews" );
    print OUT $doc->toString;
    close( OUT );
}

print $cgi->redirect( -uri => 'r.cgi?section=articles&mode=edit' );

		

		

