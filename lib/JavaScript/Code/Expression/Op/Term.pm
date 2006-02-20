package JavaScript::Code::Expression::Op::Term;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Expression::Op ];

$VERSION = '0.02';

sub new {
    my $obj   = shift;
    my $class = ref $obj || $obj;

    die("'$class' takes excatly 1 operand.")
      unless @_ == 1;

    return bless [@_], $class;
}

sub precedence { return 1000; }
sub output     { return shift->[0]; }

1;
