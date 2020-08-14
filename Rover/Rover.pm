package Rover;

my %instructions = (
						"L" => 1,
						"R" => 1,
						"M"	=> 1
					);
sub new{
	my $class = shift;
	my $args = shift;
	my $position = $args->{'position'};
	my $orientation = $args->{'orientation'};
	$self =	{ 
				position => $position,
				orientation => $orientation
			};
	bless $self, $class;
	return $self;
}

sub _move{
	my $self = shift;
	my $forwardSteps = 1;
	#strip floating point numbers
	$forward = int($forward);	
	$self->{'position'}->move({
								face => $self->{'orientation'}->{'face'},
								forwardSteps => $forwardSteps
							});

}

sub _spin{
	my $self = shift;
	my $direction = shift;
	my $degress = 90;

	#rotation should be multiples of 90
	if( $degrees%90 == 0){
		if($direction eq "L"){
			$self->{'orientation'}->antiClockwiseRotation($degress);
		}elsif($direction eq "R"){
			$self->{'orientation'}->clockwiseRotation($degress);
		}
	}else{
		print "Unsupported Rotation";
	}
}

sub _validateInstrunction{
	my $self = shift;
	my $instruction = shift;
	return (exists $instructions{$instruction} && $instructions{$instruction} == 1) ? $instructions{$instruction} : 0;
}

sub navigate{
	my $self = shift;
	my $instruction = shift;
	if($self ->_validateInstrunction($instruction)){
		if($instruction eq "M"){
			$self->_move();
		}elsif($instruction eq "L" || $instruction eq "R"){
			$self->_spin($instruction);
		}
		#add new instrunctions
	}else{
		print "Invalid Instruction when Rover at ";
		$self->printRoverPosition();
	}
}

sub printRoverStatus{
	my $self = shift;
	$self->{'position'}->printPosition();
	$self->{'orientation'}->printFace();
}

1;