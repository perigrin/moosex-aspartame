#!/usr/bin/env perl 
use strict;
use Test::More;
use Try::Tiny;
use Test::Exception;

try {

    package Kat;
    use Moose;
    use MooseX::Aspartame;
    use namespace::autoclean;

    has Int 'age', is => 'rw';
    has Str 'name', is => 'ro', default => 'Krazy';

}
catch {
    BAIL_OUT "Won't compile: $_";
};

my $krazy;
{
    lives_ok { $krazy = Kat->new( age => 6 ) }, 'got a new object';
    is( $krazy->age,  6,       'krazy right age' );
    is( $krazy->name, 'Krazy', 'krazy right name' );
}

try {

    BEGIN {
        use Moose::Util::TypeConstraints;
        subtype 'Weapon' => as 'Object';
    }

    package Mouse;
    use Moose;
    use MooseX::Aspartame;
    use namespace::autoclean;

    has Int 'age', is => 'rw';
    has Str 'name', is => 'ro', default => 'Ignatz';

    has Weapon 'weapon', is => 'ro';
    has Kat 'target', is => 'ro', default => sub { $krazy };

    package Brick;
    use Moose;
}
catch {
    BAIL_OUT "Won't compile: $_";
};

{
    my $igntz;
    lives_ok { $igntz = Mouse->new( age => 6, weapon => Brick->new ) },
      'got a new object';
    is( $igntz->age,  6,        'Ignatz right age' );
    is( $igntz->name, 'Ignatz', 'Ignatz right name' );
    isa_ok( $igntz->weapon, 'Brick' );
}
done_testing;
