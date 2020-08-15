package Book;

sub new {
  my $class = shift;
  my $self = shift if @_;
  return bless $self, $class;
}

sub type {
  my $self = shift;
  $self->{type} = shift if @_;
  return $self->{type};
}

sub title {
  my $self = shift;
  $self->{title} = shift if @_;
  return $self->{title};
}

sub author_name {
  my $self = shift;
  $self->{author_name} = shift if @_;
  return $self->{author_name};
}

1;
