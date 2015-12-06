use lib "cgi-bin";
use strict;

use Page::Object::Categories;
use Page::Object::Category;
use Page::Object::LastNews;
use Page::Object::LastSong;
use Page::Object::LastArticle;
use Page::Object::Index;

package IndexPage;

sub get
{
    my $lastSong = LastSong::get( 'Chiamami', 'Ma che minchia!' );
    my $lastArticle = LastArticle::get( 'Prova', 'Lessie?' );
    my $lastNews = LastNews::get( $lastSong, $lastArticle );
    
    my @categories = ( 'Acqua', 'proscitto', 'sabrina', 'etc.' );
    my $categories = Categories::get( Categories::listCategory( @categories ) );

    return Index::get( $categories, $lastNews );
}

1;
