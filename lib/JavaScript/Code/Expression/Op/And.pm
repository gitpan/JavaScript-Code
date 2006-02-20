package JavaScript::Code::Expression::Op::And;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Expression::Op ];

$VERSION = '0.01';

sub precedence { return 200; }
sub op         { return " && "; }

1;
