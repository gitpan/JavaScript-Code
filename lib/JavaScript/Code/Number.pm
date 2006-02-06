package JavaScript::Code::Number;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Type ];

$VERSION = '0.01';

sub type {
    return "Number";
}

sub output {
    my ($self) = @_;

    my $value = $self->value;
    $value += 0;

    return "$value";
}

1;