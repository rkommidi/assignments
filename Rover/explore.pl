use strict;

use Plateau;
use Rover;
use Position;
use Orientation;

print "Enter Input: \n";
my $firstLineInput = <>;
chomp($firstLineInput);
die "Invalid First Line Input" if($firstLineInput !~ /^\d+ \d+$/);
my ($upperX,$upperY) = split / /,$firstLineInput;
my $lowerBoundary = new Position(0,0);
my $upperBoundary = new Position($upperX,$upperY);
my $plateau = new Plateau($lowerBoundary,$upperBoundary);

my $roverFirstLine = <>;
chomp($roverFirstLine);
die "Invalid Rover First Line Input" if($roverFirstLine !~ /^\d+ \d+ [NEWS]$/);
my ($roverX,$roverY,$roverFace) = split / /,$roverFirstLine;

my $roverInitialPosition = new Position($roverX,$roverY);
my $roverInitialOrientation = new Orientation($roverFace);
my $rover = new Rover({
						position => $roverInitialPosition,
						orientation => $roverInitialOrientation
						});

my $roverSecondLine = <>;
chomp($roverSecondLine);
die "Invalid Rover Second Line Input" if($roverSecondLine !~ /^([LRM]+[LRM]*[LRM]*)+$/);
my @instructions = split //,$roverSecondLine;
while(int(@instructions) != 0){
	my $instruction = shift @instructions;
	$rover->navigate($instruction);
}


if($plateau->checkRoverPosition($rover->{'position'})){
	$rover->printRoverStatus();
}else{
		print "Out of Plateau";
}


