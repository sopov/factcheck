#!/usr/bin/perl
# https://www.youtube.com/watch?v=wWQ9YdreY9c
# https://www.youtube.com/watch?v=iSNsgj1OCLA

use strict;
use warnings;
use English qw(-no_match_vars);
use List::Util qw(shuffle);

$OUTPUT_AUTOFLUSH = 1;
my $total    = 500;
my $attempts = int( $total / 2 );
my ( $win, $lose ) = ( 0, 0 );
while (1) {
    if ( challange() ) {
        $win++;
    }
    else {
        $lose++;
    }

    show_result( $win, $lose );
}

sub show_result {
    my $win   = shift;
    my $lose  = shift;
    my $total = $win + $lose;
    if ( $total % 100 ) {
        return;
    }

    printf "\rTotal: %d; Win: %d; Lose: %d; Success: %0.2f%%", $total, $win, $lose, 100 * $win / $total;
    return;
}

sub challange {
    my $boxes = generate_boxes();
    foreach my $prisioner ( 1 .. $total ) {
        my %found         = ();
        my $test_box      = $prisioner;
        my $attempts_left = $attempts;
        while ( $attempts_left-- ) {
            $test_box = check_box( $boxes, $test_box );
            last if $test_box == $prisioner;
        }
        return if $attempts_left < 0;
    }

    return 1;
}

sub generate_boxes {
    return [ shuffle( 1 .. $total ) ];
}

sub check_box {
    my $boxes  = shift;
    my $box_id = shift;
    return $boxes->[ $box_id - 1 ];
}