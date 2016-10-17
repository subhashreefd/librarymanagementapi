class LibrarianController < ApplicationController
  def check_out
    @details = params[:detail]
    book_name = @details[:book_name]
    borrowerid = @details[:borrower_id]
    @book = Book.find_by_title(book_name)
    @borrower = Borrower.find_by_id(borrowerid)
    @book_count = @book.count
    puts("here")
    checking =  BooksOnLoan.where("book_id = ? AND borrower_id = ?", @book.id,@borrower.id)
 
    if @borrower == nil
      result = {"status" => "No Such Borrower"}
    elsif @book == nil
      result = {"status" => "No Such Book"} 
    elsif  @book != nil and @book_count == 0 
      result = {"status" => "Book is not avaialable"} 

    elsif @book != nil and @book_count > 0
  		
      if checking.exists?
       result = {"status" => "Book is already borrowed by you "} 
      else
       @book.onloan = 1
       @book.count = @book_count - 1
       @book.save
       @date_issue = Date.today 
       @date_return = Date.today + 6
  		 @books_loaned = BooksOnLoan.create(book_id: @book.id, borrower_id: @borrower.id, DateOfIssue: @date_issue, DateOfReturn: @date_return)
       @books_loaned.save
  		 result = {"status" => "Book is borrowed","Booking:id" => @books_loaned.id} 
      end
    
	  end

      render json: result.to_json
	# respond_to do |format|
	#     if 	@books_loaned.save
        
 #        format.json { render json: @books_loaned, status: :created, location: @books_loaned }
 #      else
        
 #        format.json { render json: @books_loaned, status: :unprocessable_entity }
 #      end 
 #    end  
end


def check_in
		@details = params[:detail]
    booking_id = @details[:booking_id]
    @books_loaned = BooksOnLoan.find_by_id(booking_id)
  
    if @books_loaned != nil
      bookid = @books_loaned.book_id
      @book = Book.find_by_id(bookid)
      @book_count = @book.count
      @book_count = @book_count + 1
      @book.count = @book_count
		  @book.save
		  @books_loaned.destroy
      result = {"status" => "Books returned"}
    else
      result = {"status" => "No such book borrowed"}
    end
    render json: result.to_json  
end

 def list_onloan
     @books_loaned = BooksOnLoan.all
    if @books_loaned == nil
      result = {"status" => "No books are in loan"}
      render json: result.to_json
    else
     respond_to do |format|
       format.json { render json: @books_loaned }
      end

    end
end


end
