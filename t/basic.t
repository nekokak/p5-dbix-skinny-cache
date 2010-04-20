use strict;
use warnings;
use lib './t/lib';
use Test::More;
use Mock::Basic;
use Mock::Basic2;

subtest 'cache data test' => sub {
    ok +Mock::Basic->memory_cache->param(foo => 'bar');
    is +Mock::Basic->memory_cache->param('foo'), 'bar';
    is +Mock::Basic->memory_cache->delete('foo'), 'bar';
    ok not +Mock::Basic->memory_cache->param('foo');

    done_testing;
};

subtest 'cache data test' => sub {
    my $db = Mock::Basic->new;

    ok $db->memory_cache->param(foo => 'bar');
    is $db->memory_cache->param('foo'), 'bar';
    is $db->memory_cache->delete('foo'), 'bar';
    ok not $db->memory_cache->param('foo');

    done_testing;
};

subtest 'complex test' => sub {
    ok +Mock::Basic->memory_cache->param(foo => 'bar');
    is +Mock::Basic->memory_cache->param('foo'), 'bar';


    my $db = Mock::Basic->new;
    is $db->memory_cache->param('foo'), 'bar';

    ok $db->memory_cache->param(baz => 'hoge');
    is $db->memory_cache->param('baz'), 'hoge';

    is +Mock::Basic->memory_cache->param('baz'), 'hoge';

    is $db->memory_cache->delete('foo'), 'bar';
    is $db->memory_cache->delete('baz'), 'hoge';

    ok not $db->memory_cache->param('baz');
    ok not $db->memory_cache->param('foo');
    ok not +Mock::Basic->memory_cache->param('foo');
    ok not +Mock::Basic->memory_cache->param('baz');

     done_testing;
};

subtest 'complex class test' => sub {
    ok +Mock::Basic->memory_cache->param(foo => 'bar');
    is +Mock::Basic->memory_cache->param('foo'), 'bar';

    ok not +Mock::Basic2->memory_cache->param('foo');

    ok +Mock::Basic->memory_cache->delete('foo'), 'bar';

    done_testing;
};

subtest 'delete_all' => sub {
    ok +Mock::Basic->memory_cache->param(foo => 'bar');
    ok +Mock::Basic->memory_cache->param(name => 'nekokak');

    is +Mock::Basic->memory_cache->param('foo'), 'bar';
    is +Mock::Basic->memory_cache->param('name'), 'nekokak';

    Mock::Basic->memory_cache->delete_all;

    ok not +Mock::Basic->memory_cache->param('foo');
    ok not +Mock::Basic->memory_cache->param('name');

    done_testing;
};

subtest 'get_callback' => sub {

    my $cnt=0;

    ok +Mock::Basic->memory_cache->get_callback(
        foo => sub {
            ++$cnt;
        }
    );

    is $cnt, 1;
    is +Mock::Basic->memory_cache->param('foo'), 1;

    done_testing;
};

done_testing;

