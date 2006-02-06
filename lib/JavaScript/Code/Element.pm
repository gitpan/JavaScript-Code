package JavaScript::Code::Element;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Accessor ];

$VERSION = '0.01';

=head1 NAME

JavaScript::Code::Element - a javascript-code element

=cut

sub get_indenting {
    my ($self, $intend) = @_;

    return '' unless $intend > 0;
    return '    ' x $intend;
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

