package JavaScript::Code::Expression::Node::Arithmetic;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Expression::Node ];

use JavaScript::Code::Expression::Arithmetic ();

use overload
  '+' => \&addition,
  '-' => \&subtraction,
  '*' => \&multiplication,
  '/' => \&division;

$VERSION = '0.01';

=head2 $self->add( ... )

=cut

sub addition {
    return JavaScript::Code::Expression::Arithmetic::addition(@_);
}

=head2 $self->subtraction( ... )

=cut

sub subtraction {
    return JavaScript::Code::Expression::Arithmetic::subtraction(@_);
}

=head2 $self->multiplication( ... )

=cut

sub multiplication {
    return JavaScript::Code::Expression::Arithmetic::multiplication(@_);
}

=head2 $self->division( ... )

=cut

sub division {
    return JavaScript::Code::Expression::Arithmetic::division(@_);
}

1;
