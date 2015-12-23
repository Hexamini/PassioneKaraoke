use lib "cgi-bin";
use strict;

package ParserXML;

sub getDoc
{
    my ( $parser, $file ) = @_;
    my $doc = $parser->parse_file( $file );
    
    $doc->documentElement->setNamespace( 'http://www.passionekaraoke.com', 'xs' );
    return $doc;    
}

1;
