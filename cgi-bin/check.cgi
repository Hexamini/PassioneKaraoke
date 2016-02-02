#!/usr/bin/perl -w
use lib "cgi-bin";
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use CGI;

my $cgi = new CGI;

print $cgi->header();

my $javascript = $cgi->param( 'javascript' );
my $script = $cgi->param( 'mode' ).'_'.$cgi->param( 'page' );

