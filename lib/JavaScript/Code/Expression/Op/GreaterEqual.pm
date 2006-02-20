package JavaScript::Code::Expression::Op::GreaterEqual;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Expression::Op ];

$VERSION = '0.01';

sub precedence { return 500; }
sub op         { return " >= "; }

1;
