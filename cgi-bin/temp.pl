#!/usr/bin/perl -w
use Template;
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
use lib "cgi-bin";
use Page::Object::Utility::Behavior;
use Page::ArtistPage;
use Page::ArtistsPage;
use Page::Page;

my $cgi = new CGI;
print $cgi->header();

Behavior::mngCollision( 'keywords', sub{ my ( $a, $b ) = @_; return "$a, $b"; }  );

Page::display( ArtistsPage::get() );

=Section corret
my $table = Table::get( 'Andrea', 
			'Mantovani', 
			'17 settembre 1994', 
			'+393406936174' );

my $lastNews = LastNews::get( 'Va in campagna', 'Nessuno' );
my $frame = Frame::get( $table, $lastNews );

Page::display( $frame );
=cut
