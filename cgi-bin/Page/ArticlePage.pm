use lib "cgi-bin";
use strict;

use Page::Object::Article;

package ArticlePage;

sub get
{
    return Article::get( 'Prova', 'Potrebbe piacerti', 'Me e solo me', 'Ieri', 'Pornografico soprattutto' );
}

1;
