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

my $id = $cgi->param( 'id' );
my $author = $cgi->param( 'articleAuthor' );
my $data = $cgi->param( 'articleData' );
my $title = $cgi->param( 'articleTitle' );
my $subtitle = $cgi->param( 'articleSubtitle' );
my $content = $cgi->param( 'articleContent' );
my $js = $cgi->param( 'javascript' );

$content =~ s/\n/\n /g;

my $qManager = 
    "r.cgi?section=articleManager&id=$id&mode=modify".
    "&s=$author&s=$data&s=$title&s=$subtitle&s=$content";
my $err = '';

if ( !$js ) {
    if ( !Check::check( $author, 'articleAuthor' ) ) {
	$err = $err.'&e=Nome autore non valido, inserire un testo presenti solo '.
	    'lettere e numeri&i=articleAuthor';
    } if ( !Check::check( $data, 'articleData' ) ) {
	$err = $err.'&e=La data inserita non è valida, il formato deve essere '.
	    'giorno-mese-anno. Ad esempio: 12-03-1989&i=articleData';
    } if ( !Check::check( $title, 'articleTitle' ) ) {
	$err = $err.'&e=Titolo errato, inserire un testo che presenti solo lettere e '.
	    'numeri&i=articleTitle';
    } if ( !Check::check( $subtitle, 'articleSubtitle' ) ) {
	$err = $err.'&e=Sottotitolo errato, inserire un testo che presenti solo '.
	    'lettere e numeri&i=articleSubtitle';
    } if ( !Check::check( $content, 'articleContent' ) ) {
	$err = $err.'&e=Il contenuto e\' vuoto&i=articleContent';
    }
}

if ( $err ne '' ) {
    $qManager = $qManager.$err;
    print $cgi->redirect( -uri => $qManager );
} else {
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
    
	$data = $parser->parse_balanced_chunk( "<data>$data</data>" ) 
	    || die( 'Frammento non ben formato' );
	$article->appendChild( $data );    
    }
    
    my $parserNews = XML::LibXML->new();
    my $fileNews = '../data/database/news.xml';
    my $docNews = ParserXML::getDoc( $parserNews, $fileNews );

    my $news = $docNews->findnodes( "//xs:newArticle[\@id='$id']" )->get_node( 1 );

    if( $title )
    {
	my $nodeTitle = $parser->parse_balanced_chunk( "<title><![CDATA[$title]]></title>" ) 
	    || die( 'Frammento non ben formato' );

	$article->removeChild( $article->findnodes( 'xs:title' )->get_node( 1 ) );
	$article->appendChild( $nodeTitle );

	if ( $news ) {
	    $nodeTitle = $parser->parse_balanced_chunk( "<title><![CDATA[$title]]></title>" );

	    $news->removeChild( $news->findnodes( 'xs:title' )->get_node( 1 ) );
	    $news->appendChild( $nodeTitle ) || die( 'Impossibile appendere il nodo' );
	}
    }

    if( $subtitle )
    {
	$article->removeChild( $article->findnodes( 'xs:subtitle' )->get_node( 1 ) );
	
	my $nodeSubtitle = $parser->parse_balanced_chunk( 
	    "<subtitle><![CDATA[$subtitle]]></subtitle>" 
	    ) || die( 'Frammento non ben formato' );

	$article->appendChild( $nodeSubtitle );

	if ( $news ) {
	    $nodeSubtitle = $parser->parse_balanced_chunk( 
		"<subtitle><![CDATA[$subtitle]]></subtitle>" 
		);
	    $news->removeChild( $news->findnodes( 'xs:subtitle' )->get_node( 1 ) );
	    $news->appendChild( $nodeSubtitle );
	}
    }

    if( $content )
    {
	$article->removeChild( $article->findnodes( 'xs:content' )->get_node( 1 ) );

	$content = $parser->parse_balanced_chunk( "<content><![CDATA[$content]]></content>" )
	    || die( 'Frammento non ben formato' );
	$article->appendChild( $content );
    }

    #Aggiorna la tabella degli artisti
    open( OUT, ">$file" );
    print OUT $doc->toString;
    close( OUT );
    #Aggiorna la tabella delle new
    open( OUT, ">$fileNews" );
    print OUT $docNews->toString;
    close( OUT );

    print $cgi->redirect( -uri => "r.cgi?section=article&amp;id=$id" );
}

