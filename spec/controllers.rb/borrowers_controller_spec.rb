require 'spec_helper'

RSpec.describe BorrowersController, :type => :controller  do
  
 
  describe "GET 'index'" do
    let!(:first_post)  { Borrower.create(:name => "Test get name", 
                                         :email => "email@example.com") }
    before { get :index, :format => :json }
    
   
    it "returns status code :success" do
      expect(response.status).to eq 200
    end
 
    it "renders the index template" do
      response.body.should_not eq("")
    end
    
    it "response body @authors" do
      body = JSON.parse(response.body)
      author_name = body.map { |m| m["name"] }
      author_category = body.map { |m| m["email"] }
      expect(author_name).to match_array(["Test get name"])
      expect(author_category).to match_array(["email@example.com"])
    end
    
  end

  describe "GET /borrowers/:id" do
    it "returns a requested author" do
      bo = Borrower.create(:name => "Test get name", :email => "email@example.com")
      get :show, :id => bo.id, :format => :json

      expect(response.status).to be 200

      body = JSON.parse(response.body)

      expect(:get => "/borrowers/#{bo.id}").to be_routable
      expect(body["name"]).to eq "Test get name"
    end
  
  end

  describe "POST /borrowers" do

    it "creates a borrower" do
      borrower_params = {
        "borrower" => {
          "name" => "Test create name",
          "email" => "email@example.com"
        }
      }

      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }

      before_count = Borrower.count
      post :create, borrower_params
      
      before_count = before_count + 1
      after_count = Borrower.count
      expect(before_count).to eq after_count
      expect(Borrower.first.name).to eq "Test create name"
    end
     
  end

  describe "PUT /borrowers/:id" do

    it "updates an author" do
      
      request.env["HTTP_ACCEPT"] = "application/json"
      bo = Borrower.create(:name => "Test update name", :email => "email@example.com")
      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
        put :update, :id => bo.id, borrower: {:email => "test@testmail.com"}
        bo.reload.email.should == "test@testmail.com"

     end
  end
 

   describe "DELETE /borrowers/:id" do
    it "deletes a borrower" do
     bo = Borrower.create(:name => "Test get name", :email => "email@example.com")

      before_count = Borrower.count
      delete :destroy, :id => bo.id, :format => :json

      expect(response.status).to be 204
      expect(Borrower.count).to eq 0
    
      before_count = before_count - 1
      after_count = Borrower.count

      expect(before_count).to eq after_count
      bod = Borrower.create(:name => "Test delete name", :email => "email@example.com")
       expect {
         delete :destroy, :id => bod.id
       }.to change(Borrower, :count).by(-1)

    end

  end
end