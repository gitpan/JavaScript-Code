package JavaScript::Code::Type;

use strict;
use vars qw[ $VERSION ];
use base qw[
  JavaScript::Code::Accessor
  JavaScript::Code::Value
];
use Carp;

use overload '""' => sub { shift->output };

__PACKAGE__->mk_accessors(qw[ type value ]);

use JavaScript::Code::String ();
use JavaScript::Code::Number ();
use JavaScript::Code::Array  ();
use JavaScript::Code::Hash   ();

$VERSION = '0.02';

=head1 NAME

JavaScript::Code::Type - A JavaScript Type

=head1 SYNOPSIS

    #!/usr/bin/perl

    use strict;
    use warnings;
    use JavaScript::Code::Type;

    my $type = JavaScript::Code::Type->new({ type => 'String' })->value("Go for it!");

    print $type->output;


=head1 METHODS

=head2 JavaScript::Code::Type->new( )

=cut

sub new {
    my $this  = shift;
    my $class = ref($this) || $this;

    return $class->SUPER::new(@_)
      unless $class eq __PACKAGE__;

    my $args = shift;

    my $via = lc( delete $args->{type} || '' )
      or croak "No type provided.";

    $via = ucfirst $via;
    $via = "JavaScript::Code::$via";

    eval "require $via";    # make sure, it is loaded
    croak $@ if $@;

    return $via->new( $args, @_ );
}

=head2 $self->type( )

Returns a string that represents the underlaying type.

=cut

=head2 $self->value( $value )

Gets or sets the associated value.

=cut

=head2 $self->output( )

Returns the javascript-code for that type.

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

