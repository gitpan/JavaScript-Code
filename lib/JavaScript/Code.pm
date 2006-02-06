package JavaScript::Code;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Block ];

$VERSION = '0.02';

=head1 NAME

JavaScript::Code - A JavaScript Code Framework

=head1 SYNOPSIS

    #!/usr/bin/perl

    use strict;
    use warnings;
    use JavaScript::Code;
    use JavaScript::Code::Variable;

    my $code = JavaScript::Code->new();
    my $var  = JavaScript::Code::Variable->new()->name('a')->value("Var!");

    $code->add( $var );
    $code->add( JavaScript::Code::Variable->new()->name('b')->value(42) );

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
    my $self = shift;
    my $intend = shift || 0;

    my $output = '';

    my $elements = $self->elements || [];
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
