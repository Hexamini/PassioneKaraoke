use lib "cgi-bin";
use strict;

use Page::Object::LastSong;
use Page::Object::LastArticle;
use Page::Object::Base::Behavior;

package LastNews;

my $struct = "lastNews";

=begin
Parametri:
    lastSongs = Oggetto rappresentativo un insieme di LastSong
    lastArticle = Oggetto rappresentativo un insieme di LastArticle
=cut
sub get
{
    my ( $lastSongs, $lastArticles ) = @_;

    my $fus = Behavior::weld( $lastSong, $lastArticle );
    return Behavior::getChain( $struct, $fus, 1 );
}

sub lastSongs
{
    my ( @lastSongs ) = @_;
    my $list = '';
    
    foreach my $song( @lastSongs )
    {
	$list = $list . LastSong::extractContent( $song );
    }

    return $list;
}

sub lastArticles
{
    my ( @lastArticles ) = @_;
    my $list = '';

    foreach my $article( @lastArticles )
    {
	$list = $list . LastArticle::extractContent( $article );
    }

    return $list;
}

1;
