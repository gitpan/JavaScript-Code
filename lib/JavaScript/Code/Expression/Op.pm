package JavaScript::Code::Expression::Op;

use strict;
use vars qw[ $VERSION ];
use JavaScript::Code::Expression::Op::Term;

$VERSION = '0.02';

sub new {
    my $obj   = shift;
    my $class = ref $obj || $obj;

    die("'$class' is a binary operator and must take exactly 2 operands.")
      unless @_ == 2;

    return bless [@_], $class;
}

sub children { return @{ shift() } }

sub unary { return 0; }

sub output {
    my ( $self, $precedence ) = @_;
    $precedence = 0 if not defined $precedence;
    my $output = join $self->op,
      map { $_->output( $self->precedence ) } $self->children;

    $output = "($output)" if $precedence > $self->precedence;

    return $output;
}

1;
