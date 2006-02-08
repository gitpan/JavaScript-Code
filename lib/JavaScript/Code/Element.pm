package JavaScript::Code::Element;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Accessor Clone ];

use overload
  'eq' => sub { 0 },
  '==' => sub { 0 };

__PACKAGE__->mk_accessors(qw[ parent ]);

$VERSION = '0.02';

=head1 NAME

JavaScript::Code::Element - A JavaScript Element

=head1 DESCRIPTION

Base class for javascript elements like blocks, variables, functions and so on.

=head1 METHODS

=head2 $self->clone( )

Clones the element.

=cut

=head1 SEE ALSO

L<JavaScript::Code>

=head1 AUTHOR

Sascha Kiefer, C<esskar@cpan.org>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

sub get_indenting {
    my ( $self, $intend ) = @_;

    return '' unless $intend > 1;
    return '    ' x ( $intend - 1 );
}

sub exists_in_parent {
    my ( $self, $obj, $parent ) = @_;

    unless ( defined $parent ) {
        $parent = $self->parent;
        return 0 unless defined $parent;

        return $self->exists_in_parent( $obj, $parent );
    }

    return 0 unless $parent->can('elements');
    return 0 unless $parent->elements;

    foreach my $element ( @{ $parent->elements } ) {

        last if Scalar::Util::refaddr($element) == Scalar::Util::refaddr($self);
        return 1 if $obj eq $element;

    }

    return $parent->exists_in_parent($obj);
}

1;

