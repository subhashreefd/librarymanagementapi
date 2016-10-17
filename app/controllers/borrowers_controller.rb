class BorrowersController < ApplicationController
  # GET /borrowers
  # GET /borrowers.json
  def index
    @borrowers = Borrower.all

    respond_to do |format|
      
      format.json { render json: @borrowers }
    end
  end

  # GET /borrowers/1
  # GET /borrowers/1.json
  def show
    @borrower = Borrower.find(params[:id])

    respond_to do |format|
      
      format.json { render json: @borrower }
    end
  end

  # GET /borrowers/new
  # GET /borrowers/new.json
  def new
    @borrower = Borrower.new

    respond_to do |format|
   
      format.json { render json: @borrower }
    end
  end

  # GET /borrowers/1/edit
  def edit
    @borrower = Borrower.find(params[:id])
  end

  # POST /borrowers
  # POST /borrowers.json
  def create
    @borrower = Borrower.new(borrower_params)

    respond_to do |format|
      if @borrower.save
        
        format.json { render json: @borrower, status: :created, location: @borrower }
      else
        
        format.json { render json: @borrower.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /borrowers/1
  # PUT /borrowers/1.json
  def update
    @borrower = Borrower.find(params[:id])

    respond_to do |format|
      if @borrower.update_attributes(params[:borrower])
        
        format.json { render json: @borrower, status: :created, location: @borrower }
      else
 
        format.json { render json: @borrower.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /borrowers/1
  # DELETE /borrowers/1.json
  def destroy
    @borrower = Borrower.find(params[:id])
    @borrower.destroy

    respond_to do |format|
      
      format.json { head :no_content }
    end
  end

  private
  def borrower_params
      params.require(:borrower).permit(:email, :name)
    end
end
