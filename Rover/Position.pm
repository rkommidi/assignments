package Position;

sub new{
	my $class = shift;
	my $x = shift;
	my $y = shift;
	$self =	{ 
				x => $x,
				y => $y
			};
	bless $self, $class;
	return $self;
}

sub move{
	my $self = shift;
	my $args = shift;
	my $face = $args->{'face'};
	my $forwardSteps = $args->{'forwardSteps'};
	if($face eq "N"){
		$self->{'y'} += $forwardSteps;
	}elsif($face eq "E"){
		$self->{'x'} += $forwardSteps;
	}elsif($face eq "S"){
		$self->{'y'} -= $forwardSteps;
	}elsif($face eq "W"){
		$self->{'x'} -= $forwardSteps;
	}
}

sub printPosition{
	my $self = shift;
	print $self->{'x'}." ".$self->{'y'}." ";
}
1;