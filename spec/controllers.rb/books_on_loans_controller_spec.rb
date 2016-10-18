require 'spec_helper'

RSpec.describe BooksOnLoansController, :type => :controller  do
  a = Author.create(:name => "author name", :category => "author category") 
  b = Book.create(:count => 10, :category => "Test book category", :onloan => 1, 
                    :title => "test book title", :author_name => a.name,
                    :author_id => a.id) 
  bo = Borrower.create(name: "Example User", email: "user@example.com")
  
  describe "get index'" do
    
    l = BooksOnLoan.create(book_id: b.id, borrower_id: bo.id, 
                       DateOfIssue: Date.today, DateOfReturn: Date.today + 6)
    dateToday = Date.today.to_s
    # puts(dateToday)
    date = Date.parse(dateToday)
    formatted_date = date.strftime('%a, %d %b %Y')
    let!(:loan_post) { BooksOnLoan.create(book_id: b.id, borrower_id: bo.id, 
                       DateOfIssue: Date.today.strftime('%a, %d %b %Y'), 
                       DateOfReturn: Date.today + 6) }
    
    before { get :index, :format => :json }

    it "returns status code :success" do
        expect(response.status).to eq 200
    end

    it "renders the index template" do
        response.body.should_not eq("")
    end
    
    inputdate_today = Date.parse(l.DateOfIssue.to_s)
    inputdate_7 = Date.parse(l.DateOfReturn.to_s)
    
    it "response body @books" do
        body = JSON.parse(response.body)
        loan_book = body.map { |m| m["book_id"] }
        loan_borrower = body.map { |m| m["borrower_id"] }
        loan_issue = body.map { |m| m["DateOfIssue"] }
        loan_return = body.map { |m| m["DateOfReturn"] }

        outputdate_today = Date.parse(loan_issue.to_s)
        outputdate_7 = Date.parse(loan_return.to_s)

        expect(loan_book).to eq [b.id]
        expect(loan_borrower).to eq [bo.id]
        expect(inputdate_today).to eq outputdate_today
        expect(inputdate_7).to eq outputdate_7
    end
  end

  describe "GET /booksonloans/:id" do
    it "returns a requested author" do
   
        l = BooksOnLoan.create(book_id: b.id, borrower_id: bo.id, 
                       DateOfIssue: Date.today, DateOfReturn: Date.today + 6)
        get :show, :id => l.id, :format => :json

        expect(response.status).to be 200

        body = JSON.parse(response.body)

        expect(:get => "/books_on_loans/#{l.id}").to be_routable
        expect(body["book_id"]).to eq b.id
    end
  end

end
    
