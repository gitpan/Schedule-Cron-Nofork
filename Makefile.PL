use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Schedule::Cron::Nofork',
    'VERSION_FROM'	=> 'Schedule/Cron/Nofork.pm', # finds $VERSION
    'PREREQ_PM'		=> {qw(Test::More Schedule::Cron)}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'Schedule/Cron/Nofork.pm', # retrieve abstract from module
       AUTHOR     => 'Max Maischein <corion@cpan.org>') : ()),
);