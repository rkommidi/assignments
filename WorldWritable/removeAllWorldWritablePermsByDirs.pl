#!/usr/bin/perl

#
# script which utilizes File::WorldWritable module and accept the directory or directories to be searched 
# on the command line. The script should operate in a verbose mode as speciﬁed by the “--verbose” ﬂag.
# 
#

use strict; 
use warnings; 

use File::WorldWritable;
use Getopt::Long;

my $help        =  undef;
my $verbose     =  0;
my @directories = ();

usage() if ( 
             @ARGV < 1 
            or !GetOptions(
                           'help|?'     => \$help, 
                           'dir:s{1,}'  => \@directories, 
                           'verbose'    => \$verbose,
                          )
            or defined $help 
           );
 
sub usage {
  print "Unknown option: @_\n" if ( @_ );
  print "Usage: $0 --dir DIR_PATH1 [--dir DIR_PATH2 ...] [--verbose] [--help|-?]\n";
  exit(0);
}

#validate mandatory arguments
if ( scalar(@directories) == 0 ) {
    print 'Provide atleast one directory to remove permissions';
    exit(1);
}

eval {
    local $\ = "\n";
    print 'Number of directory Paths given: '.scalar(@directories).":-\n @directories" if ($verbose);
    foreach (@directories) {
        print "Reading directory: $_" if($verbose);
        
        my @world_writable_files = getWorldWritableFilesByDir($_);
        print "Number of Files having World Writable permissions in $_ directory : ".scalar(@world_writable_files) if($verbose);
        
        foreach (@world_writable_files) {
            if (removeWorldWritablePerm($_)) {
                 print "World Writable Permission removed for $_ file" if($verbose);
            }      
        }
    }
}; warn $@ if($@);
