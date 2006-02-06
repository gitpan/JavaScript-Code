package JavaScript::Code::Variable;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Element ];

use Scalar::Util           ();
use JavaScript::Code::Type ();

__PACKAGE__->mk_accessors(qw[ name ]);

$VERSION = '0.01';

=head1 NAME

JavaScript::Code - JavaScript Code Framework

=head1 SYNOPSIS

    #!/usr/bin/perl

    use strict;
    use warnings;
    use JavaScript::Code::Variable;

    my $string = JavaScript::Code::Variable->new();
    $string->name( 'a' );
    $string->value( 'This is a Test!' );
    print $string->output;

    my $number = JavaScript::Code::Variable->new()->name('b')->value( 288957 );
    print $number->output;

    my $strnumber = JavaScript::Code::Variable->new( { name => 'c' } );
    $strnumber->value( JavaScript::Code::String->new(value => 288957) );
    print $strnumber->output;

    my $array = JavaScript::Code::Variable->new( { name => 'd' } );
    $array->value( [0, 1] );
    print $array->output;


=head1 DESCRIPTION

=head1 METHODS

=head2 $self->name( $name )

Gets or sets the name of the variable.

=cut

=head2 $self->value( $value )

Gets or sets the value of the variable.

=cut

sub value {
    my $self = shift;
    if (@_) {

        my $value   = shift;
        my $reftype = ref $value;

        my $object;
        if ( $reftype eq 'ARRAY' ) {
            $object = JavaScript::Code::Array->new( { value => $value } );
        }
        elsif ( $reftype eq 'HASH' ) {
            $object = JavaScript::Code::Hash->new( { value => $value } );
        }
        elsif ( $reftype eq 'SCALAR' or $reftype eq '' ) {
            $value = $reftype eq 'SCALAR' ? ${$value} : $value;
            $object =
              Scalar::Util::looks_like_number($value)
              ? JavaScript::Code::Number->new( { value => $value } )
              : JavaScript::Code::String->new( { value => $value } );
        }
        elsif ( $value->isa('JavaScript::Code::Type') ) {
            $object = $value;
        }

        die "Unexpected type '$reftype'." unless defined $object;

        $self->{value} = $object;

        return $self;
    }
    else {

        my $value = $self->{value};
        $self->value($value)
          unless ref $value
          and $value->isa('JavaScript::Code::Type');
        return $self->{value};
    }
}

=head2 $self->output( )

=cut

sub output {
    my ($self) = @_;

    my $name = $self->name;
    die "A JavaScript::Code::Variable needs a name." unless $name;

    my $output = "var $name";

    my $value = $self->value;
    if ( defined $value ) {
        die "Not a 'JavaScript::Code::Type'."
          unless ref $value
          and $value->isa('JavaScript::Code::Type');
        $output .= ' = ';
        $output .= $value->output;
    }

    $output .= ";\n";

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
