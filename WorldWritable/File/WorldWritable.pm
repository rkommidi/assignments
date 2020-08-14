package File::WorldWritable;

use strict;

require Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

our $VERSION = 0.01;

our @ISA     = qw(Exporter);
@EXPORT      = qw(&getWorldWritableFilesByDir &removeWorldWritablePerm);
@EXPORT_OK   = qw();


############################################
# Usage : getWorldWritableFilesByDir($dir_path)
# Purpose : Get all world writable files in given directory and its sub-directories
# Returns : An array of files
# Parameters : directory path
# Throws : if invalid directory path given, throws warning message

sub getWorldWritableFilesByDir {
	my $dir_path = shift;
	my @world_writable_files = ();
	
	if ( -d $dir_path ) {
		@world_writable_files = grep { isWorldWritableFile($_) } getAllFilesByDir($dir_path);
		return @world_writable_files;
	}
	else {
		die "Given directory $dir_path path does not exists.";
	}
}


############################################
# Usage : removeWorldWritablePerm($file)
# Purpose : Changes file permission by removing world writable access if exists
# Returns : 1 if file successfully removed world writable permission, none if file does not exists
# Parameters : file
# Throws : if invalid file is given, throws file does not exists
#	 : if unable to modify permissions, throws couldn't chmod file

sub removeWorldWritablePerm {
	my $file = shift;
	if ( -e $file ) {
		if(isWorldWritableFile($file)){ 
			my $mode = (stat($file))[2];
			chmod $mode-2, $file or warn "Couldn't chmod $file: $!";
		}
	}
	else {
		die "Given file $_ does not exists";
	}
}

############################################
# Usage : getAllFilesByDir()
# Purpose : Get all files in given directory and its sub-directories
# Returns : An array of files
# Parameters : directory path
# Throws : if invalid directory path given, throws unable to open path error message

sub getAllFilesByDir {
    my $dir_path = shift;
    opendir (my $dir_handle, $dir_path) or die "Unable to open $dir_path: $!";
    
    my @files = map  { $dir_path . '/' . $_ }
		grep { !/^\.{1,2}$/         }			#removes . and ..
		readdir($dir_handle);
		
    closedir ($dir_handle);
    return map { -d $_ ? getAllFilesByDir($_) : $_ } @files;
}

############################################
# Usage : isWorldWritableFile()
# Purpose : Check whether given file is world writable or not
# Returns : zero or non-zero scalar value
# Parameters : file_name along with its path
# Throws : if invalid file given, gives does not exists message

sub isWorldWritableFile {
	my $file = shift;
	if ( -e $file ) { 
	    my $mode = (stat($file))[2];	
	    return $mode & 00002;
	}
	else {
	    warn "Given file $file does not exists";
	}
}


1;

__END__

=pod

=head1 NAME

File::WorldWritable - Used to manage world writable files in a given directory path.


=head1 VERSION

This documentation refers to <File::WorldWritable> version 0.0.1.


=head1 SYNOPSIS

    use File::WorldWritable;

    my @world_writable_files = getWorldWritableFilesByDir($dir_path);
    removeWorldWritablePerm($dir_path);

=head1 DESCRIPTION

These routines allow you to get all filles having world writable permissions for the given directory path.
also used to remove world writeble permission without altering user and group permissions.

=over 4

=item C<getWorldWritableFilesByDir>
X<getWorldWritableFilesByDir>

    my @world_writable_files = getWorldWritableFilesByDir($dir_path);

The C<getWorldWritableFilesByDir()> routine will return array of all files present in given directory and its sub-directories having
world writable permissions. 

if the given direcoty path does not exists warns error message.

=item C<removeWorldWritablePerm>
X<removeWorldWritablePerm>

  removeWorldWritablePerm($file);

The C<removeWorldWritablePerm()> routine will remove world writable permissions of given file without altering user and group permissions.

=back

=cut

