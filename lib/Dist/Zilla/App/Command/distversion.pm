package Dist::Zilla::App::Command::distversion;
use Capture::Tiny 'capture';

# PODNAME: dzil distversion
# ABSTRACT: report the dist version on stdot
 
use strict;
use warnings;
 
our $VERSION = '0.001';
 
use Dist::Zilla::App -command;

sub abstract    { "Prints your dist version on the command line" }
sub description { "Asks dzil what version the dist is on, then prints that" }
sub usage_desc  { "%c" }
sub execute {
    my $self = shift;
	# Something might output.
	capture {
        # https://metacpan.org/source/RJBS/Dist-Zilla-6.010/lib/Dist/Zilla/Dist/Builder.pm#L348-352
		$_->gather_files       for @{ $self->zilla->plugins_with(-FileGatherer) };
		$_->set_file_encodings for @{ $self->zilla->plugins_with(-EncodingProvider) };
		$_->prune_files        for @{ $self->zilla->plugins_with(-FilePruner) };

		$self->zilla->version;
	}
    print $self->zilla->version, "\n";
}

1;

=head1 SYNOPSIS

    $ dzil distversion
    0.01
