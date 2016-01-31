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

my $id = $cgi->param( 'id' );
my $author = $cgi->param( 'articleAuthor' );
my $data = $cgi->param( 'articleData' );
my $title = $cgi->param( 'articleTitle' );
my $subtitle = $cgi->param( 'articleSubtitle' );
my $content = $cgi->param( 'articleContent' );

my $file = '../data/database/articlelist.xml';

my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my $article = $doc->findnodes( "//xs:article[\@id='$id']" )->get_node( 1 );

if( $author )
{
    $article->removeChild( $article->findnodes( 'xs:author' )->get_node( 1 ) );
    
    $author = $parser->parse_balanced_chunk( "<author><![CDATA[$author]]></author>" )
    	    || die( 'Frammento non ben formato' );
    $article->appendChild( $author );
}

if( $data )
{
    $article->removeChild( $article->findnodes( 'xs:data' )->get_node( 1 ) );
    
    $data = $parser->parse_balanced_chunk( "<data>$data</data>" ) || die( 'Frammento non ben formato' );
    $article->appendChild( $data );    
}

if( $title )
{
    $article->removeChild( $article->findnodes( 'xs:title' )->get_node( 1 ) );

    $title = $parser->parse_balanced_chunk( "<title><![CDATA[$title]]></title>" ) || die( 'Frammento non ben formato' );
    $article->appendChild( $title );
}

if( $subtitle )
{
    $article->removeChild( $article->findnodes( 'xs:subtitle' )->get_node( 1 ) );
    
    $subtitle = $parser->parse_balanced_chunk( "<subtitle><![CDATA[$subtitle]]></subtitle>" )
    	      || die( 'Frammento non ben formato' );
    $article->appendChild( $subtitle );
}

if( $content )
{
    $article->removeChild( $article->findnodes( 'xs:content' )->get_node( 1 ) );

    $content = $parser->parse_balanced_chunk( "<content><![CDATA[$content]]></content>" )
	|| die( 'Frammento non ben formato' );
    $article->appendChild( $content );
}

open( OUT, ">$file" );
print OUT $doc->toString;
close( OUT );

print $cgi->redirect( -uri => "r.cgi?section=article&amp;id=$id" );
