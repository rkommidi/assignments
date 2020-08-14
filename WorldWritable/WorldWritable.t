#
# Test script for the File::WorldWritble module using Test::More
#

use strict;
use warnings;
use Test::More qw(no_plan);

# Verify module can be included via "use" pragma
use_ok('File::WorldWritable');

# Verify module can be included via "require" pragma
require_ok( 'File::WorldWritable' );

for my $export (qw( getWorldWritableFilesByDir removeWorldWritablePerm )){
 can_ok( __PACKAGE__, $export );
}

# temporary 2 directories with each contains 2 world writable and 1 non-world writable files
my %dir_structure  =    ('./dir1' => {
                                      'test.txt'     =>      '0657'  , 
                                      'test_1.txt'   =>      '0777' ,
                                      'test_2.txt'   =>      '0751' ,
                                     },
                         './dir2' => {
                                      'test.txt'     =>      '0657' ,
                                      'test_1.txt'   =>      '0777' ,
                                      'test_2.txt'   =>      '0751' ,
                                      }                                     
                        );

foreach my $dir (keys %dir_structure){
    # Check if dir exists. If not create it.
    mkdir $dir unless -d $dir;          
    
    foreach my $files_hash ($dir_structure{$dir}){
         foreach my $file (keys %{$files_hash}){
            open my $fileHandle, '>', "$dir/$file";
            chmod oct($files_hash->{$file}), "$dir/$file";
         }
    }
    # 2 world writable files in each directory    
    is(getWorldWritableFilesByDir($dir), 2, 'getWorldWritableFilesByDir subroutine success test');         
}


#remove above created temp directories along with its files after testing
foreach my $dir(keys %dir_structure){
    system("rm -rf $dir");
}

# files hash contains keys as file names and values as its permissions
my %files  =    ( 
                  'test.txt'   => '0657' ,
                  'test_1.txt' => '0777' ,
                  'test_2.txt' => '0751' ,
                );
foreach my $file (keys %files) {
    open my $fh, '>', $file;
    chmod oct($files{$file}), $file;
    
    my $mode = (stat($file))[2];
    if($mode & 00002){          #if world writable file
        is(removeWorldWritablePerm($file), 1, 'removeWorldWritablePerm subroutine success test on world writable file');
        
        my $new_mode = (stat($file))[2];
        is($new_mode, $mode-2, 'Remove world writable permission without changing user, group permissions test');
    }
    else {
        is(removeWorldWritablePerm($file), 0, 'removeWorldWritablePerm subroutine success test on non-world writable file');
        
        my $new_mode = (stat($file))[2];
        is($new_mode, $mode, 'Permissions should be same if non-world writable file test');        
    }
}

#remove above created test files after testing
foreach (keys %files){
    unlink $_;
}