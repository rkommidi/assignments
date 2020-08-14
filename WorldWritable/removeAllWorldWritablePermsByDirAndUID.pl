#!/usr/bin/perl

#
# Script uses File::WorldWritable module that takes an additional user argument.
# The searching and permission changes should occur with the effective UID of the 
# user passed as an argument.
#

use strict; 
use warnings; 

use File::WorldWritable;
use Getopt::Long;

my $verbose	= 0;
my @directories = ();
my $uid		= undef;
my $help	= undef;

usage() if ( @ARGV < 1 
	    or !GetOptions(
			    'help|?' 	  => \$help, 
			    'dir:s{1,}'   => \@directories, 
			    'uid:i' 	  => \$uid, 
			    'verbose'     => \$verbose,
			  )
	    or defined $help 
	   );

sub usage { 
  print "Unknown option: @_\n" if ( @_ );
  print "Usage: $0 --dir=DIR_PATH1 [--dir=DIR_PATH2 ...] --uid=UID [--verbose] [--help|-?]\n";
  exit(0);
}

#validate mandatory arguments
if ( scalar(@directories) == 0 ) {
    print 'Provide atleast one directory to remove permissions';
    exit(1);
}

if (!defined $uid) {
    print 'Please provide UID.';
    exit(1);
}

eval {
    local $\ = "\n";
    print 'Number of directory Paths given: '.scalar(@directories).":-\n @directories" if($verbose);	
    foreach my $dir (@directories) {
      print "Reading directory: $dir" if($verbose);    
      
      my @world_writable_files = getWorldWritableFilesByDir($dir);      
      print "Number of Files having World Writable permissions in $dir directory : ".scalar(@world_writable_files) if($verbose);
      
      foreach my $file (@world_writable_files){
	my $file_uid = (stat($file))[4];
	my $result = removeWorldWritablePerm($file) if ($uid == $file_uid);
	print "World Writable Permission removed for $file file" if(defined $result && $result == 1 && $verbose);
      }
    }
}; warn $@ if($@);

