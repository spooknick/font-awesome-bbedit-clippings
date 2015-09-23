#!/usr/bin/env perl
# 
package main;
use warnings;
use strict;
use Data::Dumper;
use 5.016;


run( @ARGV ) unless caller();

##
# Subroutine : run
# Parameter  : css file
# Purpose    : extracts fa icons from css file and save clipping set
# Returns    : clipping files 
#


sub run{
    my $filename = shift || die 'Input filename missing';

    open(my $INFILE, '<', $filename) || die "Can't open $filename for reading!\n";
    my $icon_cnt = {};
    
    while( my $line = <$INFILE> ){
        chomp($line); # fa-glass
        next if $line !~ m/[.]fa-/;  

        my @matches = $line =~ /(fa-[a-z0-9-]+)/gmx;
        foreach my $elem (@matches) {
            $elem =~ m/(fa-[a-z0-9-]+)/gmx;
            $icon_cnt->{$1}++;
        }
    }
    close $INFILE;

    foreach my $icon (keys %{ $icon_cnt }) {
        my $clipname = $icon;
        $clipname =~ s/-/_/g;
        say $clipname;
        open(my $OUTFILE, '>', $clipname) || die "Can't open $icon for writing!\n";
        print $OUTFILE '<i class="fa ' . $icon . '"></i>';
        close $OUTFILE;
    }

}