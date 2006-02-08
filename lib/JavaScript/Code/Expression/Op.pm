package JavaScript::Code::Expression::Op;

use strict;
use vars qw[ $VERSION ];
use JavaScript::Code::Expression::Op::Term;

$VERSION = '0.01';

sub new {
    my $obj   = shift;
    my $class = ref $obj || $obj;

    return bless [@_], $class;
}

sub children { @{ shift() } }

sub output {
    my ( $self, $precedence ) = @_;
    $precedence = 0 if not defined $precedence;
    my $output = join $self->op,
      map { $_->output( $self->precedence ) } $self->children;

    $output = "($output)" if $precedence > $self->precedence;

    return $output;
}

1;
