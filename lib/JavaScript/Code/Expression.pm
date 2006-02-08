package JavaScript::Code::Expression;

use strict;
use vars qw[ $VERSION ];
use base qw[
  JavaScript::Code::Accessor
  JavaScript::Code::Value
];

__PACKAGE__->mk_ro_accessors(qw[ tree ]);

$VERSION = '0.02';

=head1 NAME

JavaScript::Code::Expression - A JavaScript Expression

=head1 DESCRIPTION

A Expression Class

=head1 METHODS

=head2 $self->tree( )

Returns a tree of L<JavaScript::Code::Expression::Op>'s

=cut

=head1 SEE ALSO

L<JavaScript::Code>

=head1 AUTHOR

Sascha Kiefer, C<esskar@cpan.org>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
