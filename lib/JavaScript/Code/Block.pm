package JavaScript::Code::Block;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Element ];

use JavaScript::Code::Variable ();

__PACKAGE__->mk_ro_accessors(qw[ elements ]);

$VERSION = '0.04';

=head1 NAME

JavaScript::Code::Block - A JavaScript Block Element

=head1 DESCRIPTION

A block element in javascript is a collection of javascript elements enclosed in brakets.

Example:

    {   // a block starts
        var a = 42;
        var b = "21 is just half the truth.";

        { // another block starts

            // ...

        } // another block ends

    }   // a block ends


=head1 SYNOPSIS

    #!/usr/bin/perl

    use strict;
    use warnings;
    use JavaScript::Code::Block;
    use JavaScript::Code::Variable;

    my $block1 = JavaScript::Code::Block->new();
    my $var1   = JavaScript::Code::Variable->new( name => 'a', value => "Var 1!" );
    my $var2   = JavaScript::Code::Variable->new()->name('b')->value("Var 2!");

    my $block2 = JavaScript::Code::Block->new();
    my $var3   = JavaScript::Code::Variable->new()->name('c')->value("Var 3!");

    $block1->add( $var1 );
    $block1->add( $var2 )->add( $block2->add( $var3 ) );
    $block1->add( JavaScript::Code::Variable->new()->name('d')->value(42) );

    print $block1->output;

=head1 METHODS

=cut

sub new {
    my $this  = shift;
    my $class = ref($this) || $this;

    my $self = $class->SUPER::new(@_);

    # cleanup the elements
    my $array = delete $self->{elements};
    $self->{elements} = [];
    $self->add($array) if defined $array;

    return $self;
}

=head2 $self->add( $element | \@elements )

Adds one or more new element(s) to the block.

=cut

sub add {
    my ( $self, $array ) = @_;

    Carp::croak 'Nothing to add.'
      unless defined $array;

    $array = [$array] unless ref $array eq 'ARRAY';

    my @elements = ();
    foreach my $element ( @{$array} ) {

        Carp::croak "Not a 'JavaScript::Code::Element'."
          unless ref $element
          and $element->isa('JavaScript::Code::Element');

        Carp::croak "Not able to a element of type 'JavaScript::Code'."
          if $element->isa('JavaScript::Code');

        push @elements, $element->clone->parent($self);
    }

    push @{ $self->{elements} }, @elements;

    return $self;
}

=head2 $self->add_variable( %args | \%args )

Creates a variable using the arguments and adds it to the the block.

=cut

sub add_variable {
    my $self = shift;

    my $var = JavaScript::Code::Variable->new( @_ );

    return $self->add( $var );
}

=head2 $self->elements( )

Returns a ref-array of all added elements.

=cut

=head2 $self->output( )

Returns the javascript-code block.

=cut

sub output {
    my $self  = shift;
    my $scope = shift || 1;

    my $indenting = $self->get_indenting($scope);
    my $output    = $indenting . "{\n";

    my $elements = $self->elements;
    foreach my $element ( @{$elements} ) {
        $output .= $element->output( $scope + 1 );
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
