package JavaScript::Code::Expression::Arithmetic;

use strict;
use vars qw[ $VERSION ];
use base qw[
  JavaScript::Code::Expression
  JavaScript::Code::Expression::Node::Arithmetic
];
use Carp;

$VERSION = '0.01';

=head1 NAME

JavaScript::Code::Expression::Arithmetic - a javascript arithmetic expression

=head1 METHODS

=cut

sub command {
    my ( $self, $op, $left, $right ) = @_;

    my $class = 'JavaScript::Code::Expression::Op::' . $op;
    eval "require $class";
    croak $@ if $@;

    my $tree = $class->new(
        $left->isa('JavaScript::Code::Expression::Arithmetic') ? $left->tree
        : JavaScript::Code::Expression::Op::Term->new( $left->clone ),
        $right->isa('JavaScript::Code::Expression::Arithmetic') ? $right->tree
        : JavaScript::Code::Expression::Op::Term->new( $right->clone )
    );

    $self->{tree} = $tree;

    return $self;
}

=head2 $self->addition( ... )

=cut

sub addition {
    my $e = __PACKAGE__->new;
    $e->command( 'Addition', @_ );
    return $e;
}

=head2 $self->subtraction( ... )

=cut

sub subtraction {
    my $e = __PACKAGE__->new;
    $e->command( 'Subtraction', @_ );
    return $e;
}

=head2 $self->multiplication( ... )

=cut

sub multiplication {
    my $e = __PACKAGE__->new;
    $e->command( 'Multiplication', @_ );
    return $e;
}

=head2 $self->division( ... )

=cut

sub division {
    my $e = __PACKAGE__->new;
    $e->command( 'Division', @_ );
    return $e;
}

=head2 $self->output( )

=cut

sub output {
    my ($self) = @_;

    my $tree = $self->tree;
    return '' unless defined $tree;
    return $tree->output;
}

=head1 SEE ALSO

L<JavaScript::Code>

=head1 AUTHOR

Sascha Kiefer, C<esskar@cpan.org>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
