package JavaScript::Code::String;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Type ];

$VERSION = '0.01';

sub type {
    return "String";
}

sub output {
    my ($self) = @_;

    my $value = $self->value;
    $value =~ s!\'!\\\'!g;

    return "'$value'";
}

1;