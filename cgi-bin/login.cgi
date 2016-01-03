#!/usr/bin/perl -w
use lib "cgi-bin";
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;
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
    print $cgi->redirect( "r.cgi?section=userPage&username=$user" );
}
else
{
    print 'User not found';
}
