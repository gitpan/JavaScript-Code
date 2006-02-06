use strict;
use Module::Build;

my $build = Module::Build->new(
    create_makefile_pl => 'traditional',
    license            => 'perl',
    module_name        => 'JavaScript::Code',
    create_readme      => 1,
    sign               => 1,
    test_files         => [ glob('t/*.t') ],
    requires           => {
        'Class::Accessor::Chained::Fast' => 0,
        'Scalar::Util'                   => 1.14
    },
);

$build->create_build_script;
