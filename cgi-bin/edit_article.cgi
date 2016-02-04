#!/usr/bin/perl -w
use lib "cgi-bin";
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
use XML::LibXML;

use Page::Object::Base::ParserXML;
use Page::Object::Base::Check;
    
my $cgi = new CGI;

my $author = $cgi->param( 'articleAuthor' );
my $data = $cgi->param( 'articleData' );
my $title = $cgi->param( 'articleTitle' );
my $subtitle = $cgi->param( 'articleSubtitle' );
my $content = $cgi->param( 'articleContent' );

$content =~ s/\n/\n /g;

my $qManager = 
    'r.cgi?section=articleManager&id=0&mode=edit'.
    "&s=$author&s=$data&s=$title&s=$subtitle&s=$content";
my $err = '';

if ( !Check::check( $author, 'articleAuthor' ) ) {
    $err = $err.'&e=Nome autore non valido, inserire un testo presenti solo '.
	'lettere e numeri';
} if ( !Check::check( $data, 'articleData' ) ) {
    $err = $err.'&e=La data inserita non è valida, il formato deve essere '.
	'giorno-mese-anno. Ad esempio: 12-03-1989';
} if ( !Check::check( $title, 'articleTitle' ) ) {
    $err = $err.'&e=Titolo errato, inserire un testo che presenti solo lettere e '.
	'numeri';
} if ( !Check::check( $subtitle, 'articleSubtitle' ) ) {
    $err = $err.'&e=Sottotitolo errato, inserire un testo che presenti solo '.
	'lettere e numeri';
} if ( !Check::check( $content, 'articleContent' ) ) {
    $err = $err.'&e=Il contenuto e\' vuoto';
}

if ( $err ne '' ) {
    $qManager = $qManager.$err;
    print $cgi->redirect( -uri => $qManager );
} else {
    #Sezione aggiunta articoli nel database
    my $file = '../data/database/articlelist.xml';

    my $parser = XML::LibXML->new();
    my $doc = ParserXML::getDoc( $parser, $file );

    my ( $id ) = $doc->findnodes( '/xs:articleList/xs:article[last()]/@id' ) =~ /_(\d+)/;
    $id = $id + 1;

    my $framment = 
	"<article id=\"_$id\"> 
           <author><![CDATA[$author]]></author>
           <data>$data</data>
           <title><![CDATA[$title]]></title>
           <subtitle><![CDATA[$subtitle]]></subtitle>
           <content><![CDATA[$content]]></content>
         </article>";

    my $article = $parser->parse_balanced_chunk( $framment ) 
	|| die( 'Frammento non ben formato' );
    my $root = $doc->findnodes( 'xs:articleList' )->get_node( 1 );

    $root->appendChild( $article ) || die( 'Non appeso' );

    open( OUT, ">$file" );
    print OUT $doc->toString;
    close( OUT );

    #Sezione per l'aggiornamento dell'ultimo articolo
    $file = '../data/database/news.xml';
    $doc = ParserXML::getDoc( $parser, $file );

    $framment =
	"<newArticle id='_$id'>
       <title><![CDATA[$title]]></title>
       <subtitle><![CDATA[$subtitle]]></subtitle>
     </newArticle>";

    my $newArticle = $parser->parse_balanced_chunk( $framment )
	|| die( 'Frammento non ben formato' );
    $root = $doc->findnodes( '//xs:articles' )->get_node( 1 );

    if ( $root->findnodes( '*' )->size() == 5 ) {
	my $oldNode = $root->findnodes( 'newArticle[1]' )->get_node( 1 );
	$root->removeChild( $oldNode );
    }

    $root->appendChild( $newArticle ) || die( 'Non appeso' );

    open( OUT, ">$file" );
    print OUT $doc->toString;
    close( OUT );

    print $cgi->redirect( 'r.cgi?section=articles&amp;mode=edit' );
}
