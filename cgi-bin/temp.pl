#!/usr/bin/perl -w
use Template;
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
use lib "cgi-bin";
use Page::ArtistPage;
use Page::ArtistsPage;
use Page::IndexPage;
use Page::Page;
use Page::SongDescriptionPage;

my $cgi = new CGI;
print $cgi->header();

Page::collision( 'keywords', sub{ my ( $a, $b ) = @_; return "$a, $b"; }  );

Page::display( SongDescriptionPage::get() );
