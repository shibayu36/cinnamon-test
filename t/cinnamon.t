use strict;
use warnings;

use base qw(Test::Class);

use Test::More;
use Path::Class;

my $root = file(__FILE__)->dir->parent;

sub startup : Test(startup) {
    qx{ cinnamon --config $root/config/deploy.pl production clean 2>/dev/null };
}

sub file_operation : Tests {
    my $out;

    $out = qx{ cinnamon --config $root/config/deploy.pl production mkdir 2>/dev/null };
    like $out, qr{\[success\]: cinnamon-test-web3, cinnamon-test-web1, cinnamon-test-web2};

    $out = qx{ cinnamon --config $root/config/deploy.pl production touch 2>/dev/null };
    like $out, qr{\[success\]: cinnamon-test-web3, cinnamon-test-web1, cinnamon-test-web2};

    $out = qx{ cinnamon --config $root/config/deploy.pl production ls 2>/dev/null };
    like $out, qr{\[cinnamon-test-web1 :: stdout\] README};
    like $out, qr{\[cinnamon-test-web2 :: stdout\] README};
    like $out, qr{\[cinnamon-test-web3 :: stdout\] README};

    $out = qx{ cinnamon --config $root/config/deploy.pl production clean 2>/dev/null };
}

__PACKAGE__->runtests;

1;
