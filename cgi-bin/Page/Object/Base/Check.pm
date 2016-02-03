use lib "cgi-bin";
use strict;
use warnings;

package Check;

my %checkTable = (
    'artistNick' => qr/^.{2,}$/, 
    'artistImage' => qr/^(\w+\.\w+)?$/,
    'artistDescription' => qr/^.+$/m,
    'albumName' => qr/^.+$/, 
    'albumImage' => qr/^\w+\.\w+$/,
    'songTitle' => qr/^.+$/,
    'songLyrics' => qr/^.+$/m,
    'songExtra' => qr/^\w+$/,
    'articleAuthor' => qr/^.+$/, 
    'articleData' => qr/^\d{1,2}-\d{1,2}-\d{4}$/,
    'articleTitle' => qr/^.+$/,
    'articleSubtitle' => qr/^.+$/,
    'articleContent' => qr/^.+$/m
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
