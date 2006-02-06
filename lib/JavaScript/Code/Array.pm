package JavaScript::Code::Array;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Type ];

$VERSION = '0.01';

sub type {
    return "Array";
}

sub output {
    die "Not yet implemented.";
}

1;