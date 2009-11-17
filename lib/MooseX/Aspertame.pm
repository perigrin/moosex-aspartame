package MooseX::Aspertame;
use strict;
use Moose::Exporter;
use Moose();
use Moose::Util::TypeConstraints;

BEGIN {
    my @TYPES = Moose::Util::TypeConstraints::list_all_type_constraints;

    for my $type (@TYPES) {
        no strict 'refs';
        *{$type} = sub { return ( shift, isa => $type, @_ ) };
    }

    Moose::Exporter->setup_import_methods( as_is => \@TYPES, );
}

1;
__END__
