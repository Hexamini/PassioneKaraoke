#!/usr/bin/perl -w
use Template;
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
use lib "cgi-bin";

use Object::Table;
use Object::LastNews;
use Object::Frame;
use Object::Page;
use Object::Utility::Behavior;

my $cgi = new CGI;
print $cgi->header();

Utility::Behavior::mngCollision( 'keywords', sub{ my ( $a, $b ) = @_; return "$a, $b"; } );

my $table = Table::get( 'Andrea', 
			'Mantovani', 
			'17 settembre 1994', 
			'+393406936174' );

my $lastNews = LastNews::get( 'Va in campagna', 'Nessuno' );
my $frame = Frame::get( $table, $lastNews );

Page::display( $frame );
