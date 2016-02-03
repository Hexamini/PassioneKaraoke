use lib "cgi-bin";
use strict;
use warnings;

package Check;

my %checkTable = (
    artistNick => /^(\w+){2,}$/, 
    artistImage => /^(\w+).(\w+)$/,
    albumName => /^(\w+)$/, 
    albumImage => /^(\w+).(\w+)$/,
    songTitle => /^(\w+)$/,
    songExtra => /^(\w+)$/,
    articleAuthor => /^(\w+)$/, 
    articleData => /^(\d+){1,2}-(\d+){1,2}-(\d+){4}$/,
    articleTitle => /^(\w+)$/,
    articleSubtitle => /^(\w+)$/
);

=Begin
Parametri:
    text = Stringa da controllare
    path = Chiave dell'array associato al controllo da eseguire
=cut
sub check {
    my ( $text, $path ) = @_;

    return ( $text =~ $checkTable{$path} );
}
