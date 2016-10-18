class BooksController < ApplicationController
  # GET /books
  # GET /books.json
  def index
    @books = Book.all

    respond_to do |format|
   
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])

    respond_to do |format|

      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
  
    
    @booktitle = Book.find_by_title(book_params[:title])
    if Book.where(:title => book_params[:title]).present?
       @book = Book.find(@booktitle.id)
       @book.count = @book.count + book_params[:count].to_i
    else
       @book = Book.new(book_params)
       if !(@book.author_id.present?)
          @book.author_id = Author.find_by_name(book_params[:author_name]).id
       end
    end

    
    respond_to do |format|
    if @book.save
        
      format.json { render json: @book, status: :created, location: @book }
    else
     
      format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
       
        format.json { render json: @book, status: :created, location: @book  }
      else
   
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      
      format.json { render json: @book, status: :created, location: @book  }
    end
  end
  private
   def book_params
      params.require(:book).permit(:author_name, :count, :onloan, :count, :title, 
                                   :category, :author_id)
    end
end
