class BooksOnLoansController < ApplicationController
  # GET /books_on_loans
  # GET /books_on_loans.json
  def index
    @books_on_loans = BooksOnLoan.all
    respond_to do |format|
      format.json { render json: @books_on_loans }
    end
  end

  # GET /books_on_loans/1
  # GET /books_on_loans/1.json
  def show
    @books_on_loan = BooksOnLoan.find(params[:id])
    respond_to do |format|
      format.json { render json: @books_on_loan }
    end
  end

  # GET /books_on_loans/new
  # GET /books_on_loans/new.json
  def new
    @books_on_loan = BooksOnLoan.new
    respond_to do |format|
      format.json { render json: @books_on_loan }
    end
  end

  # GET /books_on_loans/1/edit
  def edit
    @books_on_loan = BooksOnLoan.find(params[:id])
  end

  # POST /books_on_loans
  # POST /books_on_loans.json
  def create
    @books_on_loan = BooksOnLoan.new(params[:books_on_loan])
    respond_to do |format|
      if @books_on_loan.save
        format.json { render json: @books_on_loan, status: :created, 
                                                   location: @books_on_loan }
      else
        format.json { render json: @books_on_loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books_on_loans/1
  # PUT /books_on_loans/1.json
  def update
    @books_on_loan = BooksOnLoan.find(params[:id])
    respond_to do |format|
      if @books_on_loan.update_attributes(params[:books_on_loan])
        format.json { head :no_content }
      else
        format.json { render json: @books_on_loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books_on_loans/1
  # DELETE /books_on_loans/1.json
  def destroy
    @books_on_loan = BooksOnLoan.find(params[:id])
    @books_on_loan.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end


  def check_out
    @details = params[:detail]
    @book = Book.find_by_title(@details[:book_name])
    @borrower = Borrower.find_by_id(@details[:borrower_id])
    @book_count = @book.count
    if @borrower != nil
        checking =  BooksOnLoan.where("book_id = ? AND borrower_id = ?", @book.id,@borrower.id)
        if @book == nil
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
                @books_loaned = BooksOnLoan.create(book_id: @book.id,
                                                   borrower_id: @borrower.id, 
                                                   DateOfIssue: @date_issue, 
                                                   DateOfReturn: @date_return)
                @books_loaned.save
                result = {"status" => "Book is borrowed","Booking:id" => @books_loaned.id} 
            end
        end
    elsif @borrower == nil
        result = {"status" => "No Such Borrower"}
    end
    render json: result.to_json
  end


  def check_in
    @details = params[:detail]
    booking_id = @details[:booking_id]
    @books_loaned = BooksOnLoan.find_by_id(@details[:booking_id])
  
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

end
