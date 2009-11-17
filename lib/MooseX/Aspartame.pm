package MooseX::Aspartame;
use strict;
use Moose::Util::TypeConstraints;
use Sub::Install;

sub import {
    my $package = caller;
    my @TYPES   = Moose::Util::TypeConstraints::list_all_type_constraints;
    for my $type (@TYPES) {
        Sub::Install::reinstall_sub(
            {
                code => sub { return ( shift, isa => $type, @_ ) },
                into => $package,
                as   => $type,
            }
        );
    }
}

1;
__END__
