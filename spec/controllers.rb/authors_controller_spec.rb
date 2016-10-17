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

    end

  end

  # describe "should update article" do
  # authors = Author.create(:name => "Test name", :category => "Test category") 

 
  # put :update, :id => authors.id, params: { author: { name: "updated" } }
 
  
  # # Reload association to fetch updated data and assert that title is updated.
  # author.reload
  # assert_equal "updated", author.name


  # describe "PUT /authors/:id" do

  #   it "creates an author" do
      
  #     request.env["HTTP_ACCEPT"] = "application/json"
  #     a = Author.create(:name => "Test name", :category => "Test category1")
      
  #     author_params = {
  #       "author" => {
  #         "name" => "Test put name",
         
  #       }
  #     }

  #     request_headers = {
  #       "Accept" => "application/json",
  #       "Content-Type" => "application/json"
  #     }
  #       puts(a.name)

  #      put :update, :id => a.id, author: attributes_for(author_params)
  #      a.reload
  #      puts(a.name)
  #     # put :update, :id => a.id, author_params
  #     # expect(a.reload.name).to eq "Test put name"
  #     # before_count = before_count + 1
  #     # after_count = Author.count
  #     # expect(before_count).to eq after_count
  #     # expect(Author.first.name).to eq "Test create name"
  #     # expect {
  #     #   post :create, author_params
  #     # }.to change(Author, :count).by(1)
  #   end
  # end
end