package Orientation;

my %faces = (
				"N" => 1,
				"W" => 1,
				"E" => 1,
				"S"	=> 1,
			);

sub new{
	my $class = shift;
	my $face = shift;
	$self =	{ 
				face => $face,
			};
	bless $self, $class;
	return $self;
}

sub clockwiseRotation{
	my $self = shift;
	my $degress = shift;
	while($degress != 0){
		if($self->{'face'} eq "N"){
			$self->{'face'} = "E";
		}elsif($self->{'face'} eq "E"){
			$self->{'face'} = "S";
		}elsif($self->{'face'} eq "S"){
			$self->{'face'} = "W";
		}elsif($self->{'face'} eq "W"){
			$self->{'face'} = "N";
		}
		$degress = $degress - 90;
	}
}

sub antiClockwiseRotation{
	my $self = shift;
	my $degress = shift;
	while($degress != 0){
		if($self->{'face'} eq "N"){
			$self->{'face'} = "W";
		}elsif($self->{'face'} eq "W"){
			$self->{'face'} = "S";
		}elsif($self->{'face'} eq "S"){
			$self->{'face'} = "E";
		}elsif($self->{'face'} eq "E"){
			$self->{'face'} = "N";
		}
		$degress = $degress - 90;
	}
}

sub printFace{
	my $self = shift;
	print $self->{'face'}."\n";
}
sub validateFace{
	my $self = shift;
	$face = $self->{'face'};
	return (exists $faces{$face} && $faces{$face} == 1) ? $faces{$face} : 0;
}

1;
