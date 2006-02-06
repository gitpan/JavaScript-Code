package JavaScript::Code::Block;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Element ];

__PACKAGE__->mk_accessors(qw[ elements ]);

$VERSION = '0.01';

=head1 NAME

JavaScript::Code::Block - a block element in javascript

=head1 SYNOPSIS

    #!/usr/bin/perl

    use strict;
    use warnings;
    use JavaScript::Code::Block;
    use JavaScript::Code::Variable;

    my $block = JavaScript::Code::Block->new();
    my $var   = JavaScript::Code::Variable->new()->name('a')->value("Var!");

    $block->add( $var );
    $block->add( JavaScript::Code::Variable->new()->name('b')->value(42) );

    print $block->output;

=head1 METHODS

=head2 $self->add( $element )

Adds a new element to the block

=cut

sub add {
    my ( $self, $element ) = @_;

    die "Not a 'JavaScript::Code::Element'."
      unless ref $element
      and $element->isa('JavaScript::Code::Element');

    die "Not able to a element of type 'JavaScript::Code'."
      if $element->isa('JavaScript::Code');

    my $elements = $self->elements || [];
    push @{$elements}, $element;

    $self->elements($elements);
}

=head2 $self->elements( )

Returns a ref-array of all added elements.

=cut

=head2 $self->output( )

Returns the javascript-code block.

=cut

sub output {
    my $self = shift;
    my $intend = shift || 0;

    my $indenting = $self->get_indenting($intend);
    my $output = $indenting . "{\n";

    my $elements = $self->elements || [];
    foreach my $element ( @{$elements} ) {
        $output .= $element->output($intend + 1);
    }

    $output .= $indenting . "}\n";

    return $output;
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
