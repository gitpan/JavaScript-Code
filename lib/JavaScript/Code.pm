package JavaScript::Code;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Accessor ];

__PACKAGE__->mk_accessors(qw[ elements ]);

$VERSION = '0.01';

=head1 NAME

JavaScript::Code - JavaScript Code Framework

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

=head1 METHODS

=head2 $self->add( $element )

=cut

sub add {
    my ( $self, $element ) = @_;

    die "Not a 'JavaScript::Code::Element'."
      unless ref $element
      and $element->isa('JavaScript::Code::Element');

    my $elements = $self->elements || [];
    push @{$elements}, $element;

    $self->elements($elements);
}

=head2 $self->elements( )

=cut

=head2 $self->output( )

=cut

sub output {
    my ($self) = @_;

    my $output = '';

    my $elements = $self->elements || [];
    foreach my $element ( @{$elements} ) {
        $output .= $element->output;
    }

    return $output;
}

=head2 $self->output_for_html( < %args > )

=cut

sub output_for_html {
    my ( $self, %args ) = @_;

    $args{language} ||= 'Javascript';
    $args{type}     ||= 'text/javascript';

    my $output = '<script';
    while ( my ( $key, $val ) = each %args ) {
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
