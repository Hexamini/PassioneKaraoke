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
print $cgi->header( -charset => 'utf-8' );

my $user = $cgi->param( 'username' );
my $pass = $cgi->param( 'password' );

my $file = '../data/database/userlist.xml';
my $parser = XML::LibXML->new();

my $doc = ParserXML::getDoc( $parser, $file );

my $node = $doc->findnodes( "//xs:user[xs:username='$user' and xs:password='$pass']" )->get_node( 1 );

if( $node )
{
    print 'User found: ' . $node->findnodes( 'xs:mail/text()' );
}
else
{
    print 'User not found';
}

