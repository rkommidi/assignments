use strict;
use warnings;
 
my $filename = 'input.txt';
open(my $input_fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";

my @lines = <$input_fh>;
chomp @lines;
#print "@lines \n";
my $length = @lines;			# gets number of lines
#print "number of lines: $length \n";
# reads only first 30 lines if more than 30 lines present in input else all lines
my $max_length = ($length > 30 ) ? 30 : $length;		
my @first30lines = @lines [0..$max_length-1];
my @sortedfirst30lines = sort  @first30lines;

#  Print First 30 URLs stored in memory variable sorted by domain names
print "$_\n" for @sortedfirst30lines;
 
 my @result_set = sort{                       
                            my @a = split(/\./,$a);             #some URLS may not have subdomains
                            if(scalar(@a) == 2){                       
                               $a[2] = $a[1];                  
                               $a[1] = "";                     #assign empty string if no subdomain exists           
                            }
                            my @b = split(/\./,$b); 
                            if(scalar(@b) == 2){
                               $b[2] = $b[1];
                               $b[1] = "";                      
                            }                            
                            $a[2] cmp $b[2] ||                  #First Priority sort by TLD
                            $a[0] cmp $b[0] ||                  #Second Priority sort by domain
                            $a[1] cmp $b[1]                     #Last Priority sort by subdomain if exists
                      } @sortedfirst30lines;
 
 print "OUTPUT -> \n";
 print "$_\n" for @result_set;
 
open(my $output_fh, '>:encoding(UTF-8)', "output.txt")
        or die "Could not open file 'output.txt' $!";
foreach my $sorted_line (@result_set){
   print $output_fh  $sorted_line."\n";
}

close $input_fh;
close $output_fh;