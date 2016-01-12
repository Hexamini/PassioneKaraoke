use lib "cgi-bin";
use strict;
use XML::LibXML;

use Page::Object::UserPage;
use Page::Object::Base::ParserXML;

package UserPagePage;

my $file = '../data/database/artistlist.xml';

sub get
{
    my ( $parser, @pairs ) = @_;

    my ( $user ) = ( ( shift @pairs ) =~ /=(.+)/ );
    my $doc = ParserXML::getDoc( $parser, $file );

    return UserPage::get( $user );    
}

1;
