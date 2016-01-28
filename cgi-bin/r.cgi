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
use Page::CategoryManagerPage;
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
    case 'albumManager' { Page::display( AlbumManagerPage::get( $parser, @pairs ), $section ); }
    case 'article' { Page::display( ArticlePage::get( $parser, @pairs ), $section ); }
    case 'articles' { Page::display( ArticlesPage::get( $parser, @pairs ), $section ); }
    case 'articleManager' { Page::display( ArticleManagerPage::get( @pairs ), $section ); }
    case 'artist' { Page::display( ArtistPage::get( $parser, @pairs ), $section ); }
    case 'artists' { Page::display( ArtistsPage::get( $parser, @pairs ), $section ); }
    case 'artistManager' { Page::display( ArtistManagerPage::get( @pairs ), $section ); }
    case 'index' { Page::display( IndexPage::get( $parser ), $section ); }
    case 'login' { Page::display( LoginPage::get(), $section ); }
    case 'signin' { Page::display( SigninPage::get(), $section ); }
    case 'search' { Page::display( SearchPage::get(), $section ); }
    case 'songDescription' { Page::display( SongDescriptionPage::get( $parser, @pairs ), $section ); }
    case 'songManager' { Page::display( SongManagerPage::get( @pairs ), $section ); }
    case 'userPage' { Page::display( UserPagePage::get( $parser, @pairs ), 'login' ); }
    case 'categoryManager' { Page::display( CategoryManagerPage::get(), $section ); }
    else { Page::display( C404Page::get() ); }
}
