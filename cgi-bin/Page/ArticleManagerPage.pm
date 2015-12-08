use lib "cgi-bin";
use strict;

use Page::Object::ArticleManager;

package ArticleManagerPage;

sub get
{
    return ArticleManager::get( 0 );
}

1;
  
