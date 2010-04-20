package Mock::Basic2::Schema;
use utf8;
use DBIx::Skinny::Schema;

install_table mock_basic_2 => schema {
    pk 'id';
    columns qw/
        id
        name
        delete_fg
    /;
};

1;

