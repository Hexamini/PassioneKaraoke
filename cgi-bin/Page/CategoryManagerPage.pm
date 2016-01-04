use lib "cgi-bin";
use strict;

use Page::Object::CategoryManager;

package CategoryManagerPage;

sub get
{
    return CategoryManager::get();
}
