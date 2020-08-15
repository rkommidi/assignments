package LMS;

use Book;

sub new {
  my $class = shift;
  my $self = { };
  return bless $self, $class;
}

#add to library, stores all books in a array data structure, so you can store same copies of books
sub add_to_library {
  my $self = shift;
  my $book = shift if @_;
  
  if ($book->type eq 'reference' || $book->type eq 'fiction') {
    push @{$self->{books}} , $book;
    return 1;
  }
  else {
    warn 'Only reference or fiction book types can be added.';
    return 0;
  }
}

#search book in the library and returns if found and remove from library
sub borrow_book {
  my $self = shift;
  my $title = shift;
  
  foreach my $book (@{$self->{books}}) {
     warn 'before if';
     if ($title eq $book->title) {
       if($self->_is_borrowable($book)) {
         warn 'before remove...';
         $self->remove_from_library($book); 
         return $book;
       }
       else {
         warn 'Given book is reference book, Only fiction books can be borrowed.';
         return undef;
       }
     }
  }
  
  warn 'No Book Found.';
  return undef;
    
}

#remove the book from library
sub remove_from_library {
    my ($self,$book) = @_;
    
    my $index = 0;
    warn 'before foreach';
    foreach my $library_book (@{$self->{books}}) {
      warn "$book->title  $library_book->title";
      if ($book->title eq $library_book->title) {
        warn 'removing book....';
        splice @{$self->{books}}, $index, 1;
        last;
      }
      $index++;
    }
    
    return;
}

#only fiction book type an be borrowable
sub _is_borrowable {
  my ($self,$book) = @_;
  return ($book->type eq 'fiction') ? 1 : 0;
}

#returns all books present at that point
sub show_all_books_in_library {
  my $self = shift;
  return @{$self->{books}};
}

1;
