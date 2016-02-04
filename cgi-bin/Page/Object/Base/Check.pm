use lib "cgi-bin";
use strict;
use warnings;
use URI::Escape;

package Check;

my %checkTable = (
    'artistNick' => qr/^\w{2,}(\w| )+$/, 
    'artistImage' => qr/^(\w+\.\w+)?$/,
    'artistDescription' => qr/^.+$/m,
    'albumName' => qr/^\w{2,}(\w| )+$/, 
    'albumImage' => qr/^\w+\.\w+$/,
    'songTitle' => qr/^\w{2,}(\w| )+$/,
    'songLyrics' => qr/^.+$/m,
    'songExtra' => qr/^\w+$/,
    'articleAuthor' => qr/^\w{2,}(\w| )+$/, 
    'articleData' => qr/^\d{1,2}-\d{1,2}-\d{4}$/,
    'articleTitle' => qr/^\w{2,}(\w| )+$/,
    'articleSubtitle' => qr/^\w{2,}(\w| )+$/,
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

    #Decodifica da Windows-1252
    $text =~ s/%20/ /g;
    $text =~ s/%21/!/g;
    $text =~ s/%22/"/g;
    $text =~ s/%27/'/g;
    $text =~ s/%3C/</g;
    $text =~ s/%3E/>/g;

    return $text;
}
