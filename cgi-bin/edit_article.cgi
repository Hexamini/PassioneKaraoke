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

my $author = $cgi->param( 'articleAuthor' );
my $data = $cgi->param( 'articleData' );
my $title = $cgi->param( 'articleTitle' );
my $subtitle = $cgi->param( 'articleSubtitle' );
my $content = $cgi->param( 'articleContent' );

my $file = '../data/database/articlelist.xml';

my $parser = XML::LibXML->new();
my $doc = ParserXML::getDoc( $parser, $file );

my ( $id ) = $doc->findnodes( '/xs:articleList/xs:article[last()]/@id' ) =~ /_(\d+)/;
$id = $id + 1;

my $framment = 
    "<article id=\"_$id\"> 
           <author>$author</author>
           <title>$title</title>
           <subtitle>$subtitle</subtitle>
           <content>$content</content>
         </article>";

my $article = $parser->parse_balanced_chunk( $framment ) || die( 'Frammento non ben formato' );
my $root = $doc->findnodes( 'xs:articleList' )->get_node( 1 );

$root->appendChild( $article ) || die( 'Non appeso' );

open( OUT, ">$file" );
print OUT $doc->toString;
close( OUT );

print $cgi->redirect( 'r.cgi?section=articles&amp;mode=edit' );




