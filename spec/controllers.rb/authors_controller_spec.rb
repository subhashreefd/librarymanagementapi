require 'spec_helper'

RSpec.describe AuthorsController, :type => :controller  do
  
 
  describe "GET 'index'" do
    let!(:first_post)  { Author.create(:name => "Test get name", 
                                       :category => "Test get category") }
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
      author_category = body.map { |m| m["category"] }
      expect(author_name).to match_array(["Test get name"])
      expect(author_category).to match_array(["Test get category"])
    end
    
  end

  describe "GET /authors/:id" do
    it "returns a requested author" do
      a = Author.create(:name => "Test name1", :category => "Test category1")
      get :show, :id => a.id, :format => :json

      expect(response.status).to be 200

      body = JSON.parse(response.body)

      expect(:get => "/authors/#{a.id}").to be_routable
      expect(body["name"]).to eq "Test name1"
    end
  
  end

  describe "POST /authors" do

    it "creates an author" do
      author_params = {
        "author" => {
          "name" => "Test create name",
          "category" => "Test create category"
        }
      }

      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }

      before_count = Author.count
      post :create, author_params
      
      before_count = before_count + 1
      after_count = Author.count
      expect(before_count).to eq after_count
      expect(Author.first.name).to eq "Test create name"
      expect {
        post :create, author_params
      }.to change(Author, :count).by(1)
    end
     
  end


   describe "DELETE /authors/:id" do
    it "deletes an author" do
      a = Author.create(:name => "Test name1", :category => "Test category1")

      before_count = Author.count
      delete :destroy, :id => a.id, :format => :json

      expect(response.status).to be 204
      expect(Author.count).to eq 0
    
      before_count = before_count - 1
      after_count = Author.count

      expect(before_count).to eq after_count
      a = Author.create(:name => "Test name2", :category => "Test category2")
       expect {
         delete :destroy, :id => a.id
       }.to change(Author, :count).by(-1)
      a1 = Author.create(:name => "Test name2", :category => "Test category2")
      b = Book.create(:count => 10, :category => "Test book2 category", 
                        :onloan => 1, :title => "test book title", :author_name => a1.name, 
                        :author_id => a1.id) 
      expect{ a1.destroy}.to change{ Book.count}.by(-1)      
    end
  end

  describe "PUT /authors/:id" do

    it "updates an author" do
      
      request.env["HTTP_ACCEPT"] = "application/json"
      a = Author.create(:name => "Test name", :category => "Test category1")
    
      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
        put :update, :id => a.id, author: {:name => "Test put name"}
        a.reload.name.should == "Test put name"

     end
  end
 
end