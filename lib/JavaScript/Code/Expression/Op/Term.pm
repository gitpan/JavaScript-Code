package JavaScript::Code::Expression::Op::Term;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Expression::Op ];

$VERSION = '0.01';

sub precedence { return 100; }
sub output     { return shift->[0]; }

1;
