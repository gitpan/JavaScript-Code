package JavaScript::Code;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Block ];

$VERSION = '0.04';

=head1 NAME

JavaScript::Code - A JavaScript Code Framework

=head1 SYNOPSIS

    #!/usr/bin/perl

    use strict;
    use warnings;
    use JavaScript::Code;
    use JavaScript::Code::Variable;

    # create the code object
    my $code = JavaScript::Code->new();

    # create a code block
    my $block = JavaScript::Code::Block->new();

    # create some variables
    my $var1 = JavaScript::Code::Variable->new()->name('a');
    my $var2 = JavaScript::Code::Variable->new()->name('b')->value(42);
    my $var3 = JavaScript::Code::Variable->new()->name('c')->value(23);
    my $var4 = JavaScript::Code::Variable->new()->name('x')->declared( 1 ); # could have been declared in a other script
    my $var5 = JavaScript::Code::Variable->new()->name('y')->value( ['test', 'uhu', $var4] );

    # add some of them to the code block
    $block->add( [ $var2, $var3] );

    # create some numbers
    my $x1 = JavaScript::Code::Number->new()->value( 10 );
    my $x2 = JavaScript::Code::Number->new()->value( 20 );

    # build expressions
    my $c1 = $var2 - ($x1 + $x2 + $x1->value(30)) * $x2->value(40);
    my $c2 = $c1 * $var3;

    # assign a expression to a variable and add it to your code block
    $block->add( JavaScript::Code::Variable->new()->name('d')->value( $c2 ) );

    # add more stuff to your code block
    $block->add( JavaScript::Code::Block->new()->add( $var1->value("Bar!") ) );
    $block->add( $var1->clone->value("Foo!") ); # clone 'a' and give it a new value

    # add your block and other stuff to the code object
    $code->add( [ $var4->value( 4711 ), $var1->value( "Perl!" ) ] );
    $code->add( $block );
    $code->add( $var2->value(21) ); # 'b' with value 21 (note the different scope)
    $code->add( $var5 );
    $code->add_variable( name => 'c', value => 'Larry' );

    # output to be embedded in your html code
    print $code->output_for_html;


=head1 DESCRIPTION

Create javascript-code!

=head1 METHODS

=head2 $self->add( $element )

Adds a new element.

=cut

=head2 $self->elements( )

Returns a ref-array of all added elements.

=cut

=head2 $self->output( )

Returns the javascript-code.

=cut

sub output {
    my $self   = shift;
    my $intend = shift || 0;

    my $output = '';

    my $elements = $self->elements;
    foreach my $element ( @{$elements} ) {
        $output .= $element->output;
    }

    return $output;
}

=head2 $self->output_for_html( < \%args > )

Returns the javascript-code that can be directly embedded into html-code.

Optimal \%args: Key-value pairs that reprensent attributes that will be associated to the script tag.

    print $code->output_for_html( { language => undef } );

=cut

sub output_for_html {
    my ( $self, $args ) = @_;

    $args ||= {};
    $args->{language} =
      exists $args->{language}
      ? $args->{language}
      : 'Javascript';
    $args->{type} =
      exists $args->{type}
      ? $args->{type}
      : 'text/javascript';

    my $output = '<script';
    while ( my ( $key, $val ) = each %{$args} ) {
        next unless defined $val;
        $output .= qq~ $key="$val"~;
    }
    $output .= "><!--\n\n";
    $output .= $self->output;
    $output .= "\n// --></script>\n";

    return $output;
}

=head1 SEE ALSO

L<JavaScript::MochiKit>

L<http://www.perl-community.de>

=head1 AUTHOR

Sascha Kiefer, C<esskar@cpan.org>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
