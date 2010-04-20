package DBIx::Skinny::Mixin::Cache::Memory;
use strict;
use warnings;

sub register_method {
    +{
        'memory_cache' => sub {
            my $class = shift;

            $class = ref $class || $class;
            unless ($class->can('_memory_cache_class')) {
                no strict 'refs';
                my $_memory_cache_class = DBIx::Skinny::Cache::Memory->new;
                *{"$class\::_memory_cache_class"} = sub { $_memory_cache_class };
            }

            $class->_memory_cache_class;
        }
    },
}

package DBIx::Skinny::Cache::Memory;
use strict;
use warnings;

sub new {
    my $class = shift;

    bless {
        _cache => +{},
    }, $class;
}

sub param {
    my ($self, $key, $val) = @_;

    if (defined $val) {
        $self->{_cache}->{$key} = $val;
    } else {
        $self->{_cache}->{$key};
    }
}

sub get_callback {
    my ($self, $key, $callback)  = @_;

    my $data = $self->{_cache}->{$key};
    return $data if defined $data;

    $data = $callback->();

    $self->{_cache}->{$key} = $data if defined $data;

    $data;
}

sub delete {
    my ($self, $key) = @_;
    delete $self->{_cache}->{$key};
}

sub delete_all {
    my $self = shift;
    delete $self->{_cache}->{$_} for keys %{$self->{_cache}};
}

1;

