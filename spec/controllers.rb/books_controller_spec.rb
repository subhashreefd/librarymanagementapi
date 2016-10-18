require 'spec_helper'

RSpec.describe BooksController, :type => :controller  do
  
 
  describe "GET 'index'" do
    a = Author.create(:name => "Test name for book", :category => "Test category for book") 
    let!(:book_post)  { Book.create(:count => 10, :category => "Test book category", 
                                    :onloan => 1, 
        :title => "test book title", :author_name => a.name, :author_id => a.id) }
    before { get :index, :format => :json }

    it "returns status code :success" do
        expect(response.status).to eq 200
    end

    it "renders the index template" do
        response.body.should_not eq("")
    end
    
    it "response body @books" do
        body = JSON.parse(response.body)
        book_count = body.map { |m| m["count"] }
        book_category = body.map { |m| m["category"] }
        book_onloan = body.map { |m| m["onloan"] }
        book_title = body.map { |m| m["title"] }
        book_author_name = body.map { |m| m["author_name"] }
        expect(book_count).to eq [10]
        expect(book_category).to eq ["Test book category"]
        expect(book_onloan).to eq [1]
        expect(book_title).to eq ["test book title"]
        expect(book_author_name).to eq [a.name]
    end
    

  end

  describe "GET /books/:id" do
    it "returns a requested books" do
        a = Author.create(:name => "Test name1 for book",
                          :category => "Test category1 for book") 
        b = Book.create(:count => 10, :category => "Test book1 category", 
                        :onloan => 1, :title => "test book title", 
                        :author_name => a.name, :author_id => a.id) 
        get :show, :id => b.id, :format => :json

        expect(response.status).to be 200

        body = JSON.parse(response.body)

        expect(:get => "/books/#{b.id}").to be_routable
        expect(body["title"]).to eq "test book title"
    end
  
  
  end

  describe "POST /books" do
    
    a = Author.create(:name => "Test name2 for book", :category => "Test category1 for book") 
    puts(a.inspect)
    it "creates a book" do
      book_params = {
        "book" => {
          "title" => "Test create book",
          "category" => "Test create category",
          "count" => "10",
          "onloan" => "1",
          "author_name" => a.name,  
          "author_id" => a.id
        }
      }

      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }

      before_count = Book.count
      post :create, book_params
      
      before_count = before_count + 1
      after_count = Book.count
      expect(before_count).to eq after_count
      expect(Book.first.title).to eq "Test create book"

     
    end

    it "if book already exist count should_not be changed" do
      book_params = {
        "book" => {
          "title" => "Test create book",
          "category" => "Test create category",
          "count" => "20",
          "onloan" => "1",
          "author_name" => a.name,  
          "author_id" => a.id
        }
      }
     
      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }

     
      post :create, book_params
      before_count = Book.count
      book_params = {
        "book" => {
          "title" => "Test create book",
          "category" => "Test create category",
          "count" => "25",
          "onloan" => "1",
          "author_name" => a.name,  
          "author_id" => a.id
        }
      }

      post :create, book_params
      after_count = Book.count
      expect(before_count).to eq after_count
      expect(Book.first.count).to eq 45
    end
  end

  describe "DELETE /books/:id" do
    it "deletes a book" do
        a = Author.create(:name => "Test name2 for book", 
                          :category => "Test category2 for book") 
        b = Book.create(:count => 10, :category => "Test book2 category", 
                        :onloan => 1, :title => "test book title", :author_name => a.name, 
                        :author_id => a.id) 
        before_count = Book.count
        delete :destroy, :id => b.id, :format => :json
        expect(Book.count).to eq 0
        before_count = before_count - 1
        after_count = Book.count
        expect(before_count).to eq after_count
        a1 = Author.create(:name => "Test name3 for book", 
                           :category => "Test category3 for book") 
        b1 = Book.create(:count => 10, :category => "Test book3 category", 
                         :onloan => 1, :title => "test book title", 
                         :author_name => a.name, :author_id => a.id) 
        expect {
            delete :destroy, :id => b1.id
        }.to change(Book, :count).by(-1)
    end
  end

end