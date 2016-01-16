#!/usr/bin/perl -w
use lib "cgi-bin";
use strict;
use CGI;
use CGI::Session;

my $cgi = new CGI;
my $sid = $cgi->cookie( 'CGISESSID' );

my $session = new CGI::Session( undef, $sid, { Directory => '../data/pgnac' } );

#Rimozione sessione corrente
$session->close();
$session->delete();
$session->flush();

print $cgi->redirect( 'r.cgi?section=index' );
