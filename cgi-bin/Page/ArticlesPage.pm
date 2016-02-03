use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::Articles;
use Page::Object::ArticleList;
use Page::Object::EditButton;
use Page::Object::Base::ParserXML;
use Page::Object::Base::Session;

package ArticlesPage;

my $file = '../data/database/articlelist.xml';

sub get
{
    my ( $parser, @pairs ) = @_;
    my $doc = ParserXML::getDoc( $parser, $file );

    my $size = @pairs;
    my ( $mode ) = ( ( shift @pairs ) =~ /=(.+)/ );

    my $editMode = ( $size == 1 && $mode == 'edit' );
    
    my @nodes = $doc->findnodes( '/xs:articleList/xs:article' );
    my @articles = ();

    foreach my $node( @nodes )
    {
	my $title = ParserXML::getContent( $node->findnodes( 'xs:title/text()' ) );
	my $subtitle = ParserXML::getContent( $node->findnodes( 'xs:subtitle/text()' ) );
	my $id = $node->getAttribute( 'id' ); 
	
	push( 
	    @articles, 
	    ( $editMode == 1 ) ? 
	    ArticleList::get(
		$title,
		$subtitle,
		$id,
		EditButton::get(
		    "r.cgi?section=articleManager&amp;id=$id&amp;mode=modify",
		    'modifica',
		    'Modifica articolo',
		    'modifyButton'
		),
		EditButton::get(
		    'remove_article.cgi',
		    'rimuovi',
		    'Rimuovi articolo',
		    'removeButton',
		    "$id"
		)
	    ) :
	    ArticleList::get( $title, $subtitle, $id )
	 );
    }

    @articles = reverse @articles;
    
    my $user = Session::getSession();
    my $articlesPage = '';

    if ( !Session::isAdmin( $user, $parser ) ) {
	$articlesPage = Articles::get( Articles::articleList( @articles ) );
    } else {
	if ( $editMode == 1 ) {
	    $articlesPage = Articles::get( 
		Articles::articleList( @articles ),
		EditButton::get( 
		    'r.cgi?section=articles&amp;mode=edit', 
		    'Sezione amministrativa', 
		    'editButton'
		),
		EditButton::get( 
		    'r.cgi?section=articleManager&amp;id=0&amp;mode=edit', 
		    'aggiungi', 
		    'Aggiungi articolo',
		    'addButton'
		)
	    );

	} else {

	    $articlesPage = Articles::get( 
		Articles::articleList( @articles ),
		EditButton::get( 
		    'r.cgi?section=articles&amp;mode=edit', 
		    'Sezione amministrativa', 
		    'editButton'
		)
            );
	}
    }

    return $articlesPage;
}

1;
