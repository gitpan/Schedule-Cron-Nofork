package Schedule::Cron::Nofork;

use strict;
use warnings;

#require Exporter;
#use AutoLoader qw(AUTOLOAD);

use base 'Schedule::Cron';

use vars qw($VERSION);
#our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

$VERSION = '0.01';

sub execute {
  my $self = shift;

  my $index = shift;
  my $args = $self->{args}->[$index];

  my $dispatch = $args->[0];
  die "No subroutine provided with $dispatch"
    unless ref($dispatch) eq "CODE";
  $args = $args->[1];

  my @args;
  if (defined($args) && defined($args->[0])) {
    push @args,@$args;
    #dbg "Calling dispatch with ","@args";
  } else {
    #dbg "Calling dispatch with no args";
  }

  $dispatch->(@args);
};

1;
__END__

=head1 NAME

Schedule::Cron::Nofork - Nonforking cron module

=head1 SYNOPSIS

  use Schedule::Cron::Nofork;
  
  sub dispatcher {
    print "ID:   ",shift,"\n";
    print "Args: ","@_","\n";
  };
  
  my $cron = new Schedule::Cron::Nofork(\&dispatcher);
  $cron->add_entry("0 11 * * Mon-Fri",\&check_links);
  $cron->run();
  
=head1 DESCRIPTION

C<Schedule::Cron::Nofork> is a nonforking version of C<Schedule::Cron>,
so all jobs will run from one process. This has the advantage that it
works on systems that do not have the C<fork()> call and even on systems
that have it, keeps the system load low because you don't have to create
a new process for every cron job. It has the disadvantages that one long
running job can disrupt the rest of the schedule and that a programming
error in one job will bring down the whole program.

=head2 EXPORT

None by default.

=head1 AUTHOR

Maximilian Maischein, E<lt>corion@cpan.orgE<gt>

=head1 SEE ALSO

L<Schedule::Cron>, L<crontab(5)>.

=cut