package JavaScript::Code::Expression::Op::Not;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Expression::Op ];

$VERSION = '0.01';

sub new {
    my $obj   = shift;
    my $class = ref $obj || $obj;

    die("'$class' is a unary operator and must take exactly 1 operand.")
      unless @_ == 1;

    return bless [@_], $class;
}

sub unary      { return 1; }
sub precedence { return 300; }

sub output {
    my ( $self, $precedence ) = @_;
    $precedence = 0 if not defined $precedence;

    my $output = ($self->children())[0]->output( $self->precedence );
    $output = "!$output";
    $output = "($output)" if $precedence > $self->precedence;

    return $output;
}

1;
