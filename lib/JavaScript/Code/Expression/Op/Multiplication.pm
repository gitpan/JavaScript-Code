package JavaScript::Code::Expression::Op::Multiplication;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Expression::Op ];

$VERSION = '0.01';

sub precedence { return 20; }
sub op         { return " * "; }

1;
