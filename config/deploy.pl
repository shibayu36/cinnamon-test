use strict;
use warnings;

# Exports some commands
use Cinnamon::DSL;

my $application = 'cinnamon-test';

# It's required if you want to login to remote host
set user     => 'vagrant';
set password => 'vagrant';

# User defined params to use later
set application => $application;

set deploy_to => sub {
    return '/home/vagrant/' . get('application');
};

role production => ['cinnamon-test-web1', 'cinnamon-test-web2', 'cinnamon-test-web3'];

# Tasks
task mkdir => sub {
    my ($host, @args) = @_;

    my $deploy_to = get("deploy_to");
    remote {
        run "mkdir $deploy_to";
    } $host;
};

task touch => sub {
    my ($host, @args) = @_;

    my $deploy_to = get("deploy_to");
    remote {
        run "cd $deploy_to && touch README";
    } $host;
};

task ls => sub {
    my ($host, @args) = @_;

    my $deploy_to = get("deploy_to");
    remote {
        run "ls $deploy_to";
    } $host;
};

task clean => sub {
    my ($host, @args) = @_;

    my $deploy_to = get("deploy_to");
    remote {
        run "rm -rf $deploy_to";
    } $host;
};
