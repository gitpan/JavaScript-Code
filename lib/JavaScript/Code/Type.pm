package JavaScript::Code::Type;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Accessor ];

__PACKAGE__->mk_accessors(qw[ type value ]);

use JavaScript::Code::String ();
use JavaScript::Code::Number ();
use JavaScript::Code::Array  ();
use JavaScript::Code::Hash   ();

$VERSION = '0.01';

=head1 NAME

JavaScript::Code::Type - Represents a javascript type

=head1 METHODS

=head2 $self->type( )

=cut

=head2 $self->value( )

=cut

=head2 $self->output( )

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

