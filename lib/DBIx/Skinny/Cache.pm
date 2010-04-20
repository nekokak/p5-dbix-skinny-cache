package DBIx::Skinny::Cache;
use strict;
use warnings;
our $VERSION = '0.01';

1;
__END__

=head1 NAME

DBIx::Skinny::Cache -

=head1 SYNOPSIS

    package Mock::Basic;
    use DBIx::Skinny setup => +{
        dsn => 'dbi:SQLite:',
        username => '',
        password => '',
        connect_options => { AutoCommit => 1 },
    };
    use DBIx::Skinny::Mixin modules => ['Cache::Memory'];

    # in your script:
    use Mock::Basic;
    # set data
    Mock::Basic->memory_cache->param(foo => 'bar');
    # get data
    Mock::Basic->memory_cache->param('foo'); # get bar
    # delete data
    Mock::Basic->memory_cache->delete('foo');
    # get_callback
    Mock::Basic->memory_cache->get_callback(
        foo => sub {
            # some process.....
            'return data for cache';
        }
    );

=head1 DESCRIPTION

DBIx::Skinny::Cache provide cache components.

=head1 AUTHOR

Atsushi Kobayashi E<lt>nekokak _at_ gmail _dot_ comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
