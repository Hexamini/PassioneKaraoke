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
use Page::Page;

my $cgi = new CGI;
print $cgi->header();

Page::collision( 'keywords', sub{ my ( $a, $b ) = @_; return "$a, $b"; }  );

Page::display( ArtistsPage::get() );
