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

#Funzione di prova =============================================================

use Object::UserPage;
use Object::AdminTools;

sub userPage
{
    my $username = 'korut94';

    my $adminTools = AdminTools::get( { 'articleManager' => 'La', }, { 'artistManager' => 'mia', }, { 'albumManager' => 'casa', } );
    my $userPage = UserPage::get( $username, $adminTools );
    Page::display( $userPage );
}

#===============================================================================

my $cgi = new CGI;
print $cgi->header();

Behavior::mngCollision( 'keywords', sub{ my ( $a, $b ) = @_; return "$a, $b"; }  );
userPage();

=Section corret
my $table = Table::get( 'Andrea', 
			'Mantovani', 
			'17 settembre 1994', 
			'+393406936174' );

my $lastNews = LastNews::get( 'Va in campagna', 'Nessuno' );
my $frame = Frame::get( $table, $lastNews );

Page::display( $frame );
=cut
