#!/usr/bin/perl -w
use lib "cgi-bin";
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
use CGI::Session;
use XML::LibXML;

use Page::Object::Base::ParserXML;
    
my $cgi = new CGI;

my $user = $cgi->param( 'username' );
my $pass = $cgi->param( 'password' );

my $file = '../data/database/userlist.xml';
my $parser = XML::LibXML->new();

my $doc = ParserXML::getDoc( $parser, $file );
my $node = $doc->findnodes( "//xs:user[\@username='$user' and xs:password='$pass']" )->get_node( 1 );

if( $node )
{
    my $dir = '../data/pgnac';

    #Se non esiste la cartella per mantenere le sessioni quest'ultima viene creata
    if ( !( -d $dir ) ) {
	mkdir $dir;
    }

    my $session = new CGI::Session( 'driver:File', undef, { Directory => $dir } ); #Crea la sessione
    my $cookie = $cgi->cookie( 'CGISESSID' => $session->id );

    $session->param( 'user', $user );
    print $cgi->redirect( -uri => 'r.cgi?section=index', -cookie => $cookie );
}
else
{
    print $cgi->header( -charset => 'utf-8' );
    print 'User not found';
}
