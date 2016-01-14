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

my $username = $cgi->param( 'username' );
my $mail = $cgi->param( 'email' );
my $pass = $cgi->param( 'password' );

my $file = '../data/database/userlist.xml';
my $parser = XML::LibXML->new();

my $doc = ParserXML::getDoc( $parser, $file );

my $node = $doc->findnodes( "//xs:user[xs:username='$username']" )->get_node( 1 );

if( $node )
{
    print 'User already exist';
}

else
{
    my $framment = 
	"<user id=\"$username\"> 
           <username> $username </username>
           <mail> $mail </mail> 
           <password> $pass </password>
           <votes></votes>
         </user>";

    my $user = $parser->parse_balanced_chunk( $framment ) || die( 'Frammento non ben formato' );
    my $root = $doc->findnodes( 'xs:userList' )->get_node( 1 );

    $root->appendChild( $user ) || die( 'Non appeso' );

    open( OUT, ">$file" );
    print OUT $doc->toString;
    close( OUT );

    $cgi->redirect( "r.cgi?username=$username" );
}


