#!/usr/bin/perl

use strict;
use warnings;
use diagnostics;
use Book;
use LMS;

#create some books #my $book_one;

my $book_one = new Book({ type        =>'fiction',
                          title       =>'fiction one',
                          author_name =>'fiction one author'
                        });

my $book_two = new Book({ type        =>'reference',
                          title       =>'ref one',
                          author_name =>'ref one author'
                        });

my $book_three = new Book({ type      =>'fiction',
                          title       =>'fiction three',
                          author_name =>'fiction three author'
                        });

my $book_four = new Book({ type        =>'fiction',
                           title       =>'fiction four',
                           author_name =>'fiction four author'
                        });

my $book_five = new Book({ type        =>'comedy',
                           title       =>'comedy four',
                           author_name =>'comedy four author'
                        });
		       #create library object and add above books
my $lms = new LMS();
$lms->add_to_library($book_one);
$lms->add_to_library($book_two);
$lms->add_to_library($book_three);
$lms->add_to_library($book_four);
#$lms->add_to_library($book_five);

#borrow book by passing book title $lms->borrow_book('fiction three');
#$lms->borrow_book('ref one'); #$lms->borrow_book('comedy four');

my @books = $lms->show_all_books_in_library();

foreach my $book (@books) {
   print $book->title."\n";
}

exit(0);
