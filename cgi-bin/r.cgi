#!/usr/bin/perl -w
use Template;
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
use Switch;
use XML::LibXML;

use lib "cgi-bin";
use Page::ArtistPage;
use Page::ArtistsPage;
use Page::IndexPage;
use Page::Page;
use Page::SongDescriptionPage;
use Page::SongManagerPage;
use Page::ArtistManagerPage;
use Page::AlbumManagerPage;
use Page::ArticlePage;
use Page::LoginPage;
use Page::SigninPage;
use Page::ArticleManagerPage;
use Page::ArticlesPage;
use Page::UserPagePage;
use Page::SearchPage;
use Page::C404Page;

my $cgi = new CGI;
print $cgi->header( -charset => 'utf-8' );

Page::collision( 'keywords', sub{ my ( $a, $b ) = @_; return "$a, $b"; }  );

my $buffer = $ENV{ 'QUERY_STRING' };
my @pairs = split( /&/, $buffer );

my ( $section ) = ( ( shift @pairs ) =~ /=(.+)/ );
my $parser = XML::LibXML->new();

switch( $section )
{
    case 'albumManager' { Page::display( AlbumManagerPage::get( $parser, @pairs ) ); }
    case 'article' { Page::display( ArticlePage::get( $parser, @pairs ) ); }
    case 'articles' { Page::display( ArticlesPage::get( $parser ) ); }
    case 'articleManager' { Page::display( ArticleManagerPage::get() ); }
    case 'artist' { Page::display( ArtistPage::get( $parser, @pairs ) ); }
    case 'artists' { Page::display( ArtistsPage::get( $parser ) ); }
    case 'artistManager' { Page::display( ArtistManagerPage::get() ); }
    case 'index' { Page::display( IndexPage::get( $parser ) ); }
    case 'login' { Page::display( LoginPage::get() ); }
    case 'signin' { Page::display( SigninPage::get() ); }
    case 'search' { Page::display( SearchPage::get() ); }
    case 'songDescription' { Page::display( SongDescriptionPage::get( $parser, @pairs ) ); }
    case 'songManager' { Page::display( SongManagerPage::get() ); }
    case 'userPage' { Page::display( UserPagePage::get( $parser, @pairs ) ); }
    else { Page::display( C404Page::get() ); }
}
