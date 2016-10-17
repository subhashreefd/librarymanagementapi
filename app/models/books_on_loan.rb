class BooksOnLoan < ActiveRecord::Base
  attr_accessible :book_id, :borrower_id, :DateOfIssue, :DateOfReturn
  belongs_to  :book 
  belongs_to  :borrower
end
