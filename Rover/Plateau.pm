package Plateau;

sub new{
	my $class = shift;
	my $lowerBoundary = shift;
	my $upperBoundary = shift;
	$self =	{ 
				lowerBoundary => $lowerBoundary,
				upperBoundary => $upperBoundary
			};
	bless $self, $class;
	return $self;
}
sub checkRoverPosition{
	my $self = shift;
	my $roverPosition = shift;
	if($roverPosition->{'x'} < $self->{'lowerBoundary'}->{'x'} || $roverPosition->{'y'} < $self->{'lowerBoundary'}->{'y'}){
		return 0;
	}elsif($roverPosition->{'x'} > $self->{'upperBoundary'}->{'x'} || $roverPosition->{'y'} > $self->{'upperBoundary'}->{'y'}){
		return 0;
	}else{
		return 1;
	}
}

1;