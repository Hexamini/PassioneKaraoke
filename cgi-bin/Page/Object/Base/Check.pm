use lib "cgi-bin";
use strict;
use warnings;

package Check;

my %checkTable = (
    'artistNick' => qr/^\w{2,}$/, 
    'artistImage' => qr/^(\w+\.\w+)?$/,
    'artistDescription' => qr/^.+$/,
    'albumName' => qr/^\w+$/, 
    'albumImage' => qr/^\w+\.\w+$/,
    'songTitle' => qr/^\w+$/,
    'songExtra' => qr/^\w+$/,
    'articleAuthor' => qr/^\w+$/, 
    'articleData' => qr/^\d{1,2}-\d{1,2}-\d{4}$/,
    'articleTitle' => qr/^\w+$/,
    'articleSubtitle' => qr/^\w+$/
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

=Begin
Parametri:
    text = Espressione da pulire da tutti i caratteri non desiderabili
=cut
sub cleanExpression {
    my ( $text ) = @_;

    $text =~ s/%20/ /g;
    $text =~ s/%27/'/g;
    $text =~ s/%3C/</g;
    $text =~ s/%3E/>/g;
    
    return $text;
}
