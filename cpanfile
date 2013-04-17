requires 'perl', '5.008001';

on configure => sub {
    requires 'CPAN::Meta';
    requires 'CPAN::Meta::Prereqs';
};

on test => sub {
    requires 'Test::More', '0.98';
    requires 'Test::RedisServer' => 0;
    recommends 'Redis' => 0;
    recommends 'RedisDB' => 0;
};

on develop => sub {
    requires 'Redis';
    requires 'RedisDB';
    requires 'Pod::Wordlist::hanekomu';
    requires 'Test::CPAN::Meta';
    requires 'Test::MinimumVersion', '0.10108';
    requires 'Test::Pod', '1.41';
    requires 'Test::Spelling';
};

requires 'parent' => 0;
recommends 'Redis' => 0;
recommends 'RedisDB' => 0;
requires 'Class::Accessor::Lite' => 0;
requires 'Class::Load' => 0;
requires 'String::CamelCase' => 0;
