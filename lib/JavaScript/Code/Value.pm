package JavaScript::Code::Value;

use strict;
use vars qw[ $VERSION ];
use base qw[ Clone ];
use JavaScript::Code::Variable ();

$VERSION = '0.02';

=head1 NAME

JavaScript::Code::Value - A JavaScript Value

=head2 SYNOPSIS

    use base qw[ JavaScript::Code::Value ];

=head1 DESCRIPTION

A value can e.g. be assigned to a variable.

=head1 METHODS

=head2 $self->as_variable( ... )

=cut

sub can_be_assigned { return 1; }

sub as_variable {
    my $self = shift;
    my $args = $self->args(@_);

    return JavaScript::Code::Variable->new(
        name  => $args->{name},
        value => $self
    );
}

=head1 SEE ALSO

L<JavaScript::Code>, L<JavaScript::Code::Variable>

=head1 AUTHOR

Sascha Kiefer, C<esskar@cpan.org>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
