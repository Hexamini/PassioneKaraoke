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

my $cgi = new CGI;
print $cgi->header( -charset => 'utf-8' );

Page::collision( 'keywords', sub{ my ( $a, $b ) = @_; return "$a, $b"; }  );

my $buffer = $ENV{ 'QUERY_STRING' };
my @pairs = split( /&/, $buffer );

my ( $section ) = ( $pairs[0] =~ /=(.+)/ );

switch( $section )
{
    case 'albumManager' { Page::display( AlbumManagerPage::get() ); }
    case 'article' { Page::display( ArticlePage::get() ); }
    case 'articles' { Page::display( ArticlesPage::get() ); }
    case 'articleManager' { Page::display( ArticleManagerPage::get() ); }
    case 'artist' { Page::display( ArtistPage::get() ); }
    case 'artists' { Page::display( ArtistsPage::get() ); }
    case 'artistManager' { Page::display( ArtistManagerPage::get() ); }
    case 'index' { Page::display( IndexPage::get() ); }
    case 'login' { Page::display( LoginPage::get() ); }
    case 'signin' { Page::display( SigninPage::get() ); }
    case 'songDescription' { Page::display( SongDescriptionPage::get() ); }
    case 'songManager' { Page::display( SongManagerPage::get() ); }
    case 'userPage' { Page::display( UserPagePage::get() ); }
    else { die "Error 404: page not found!"; }
}
