require 'spec_helper'

describe Book do

  before { @book = Book.new(:title => "example title", :category => "examplecategory", 
                            :count => 10) }
  subject { @book }

  it { should respond_to(:title) }
  it { should respond_to(:category) }
  it { should respond_to(:count) }
  it { should be_valid }

  describe "when  title cannot be empty" do
    before { @book.title = " " }
    it { should_not be_valid }
  end
  
  describe "when  cannot be empty" do
    before { @book.category = " " }
    it { should_not be_valid }
  end

  describe "when count cannot be empty" do
    before { @book.count = nil }
    it { should_not be_valid }
  end

  describe "when count format is invalid" do
    it "should be invalid" do
      values = [-2,2.5,2.55,0.35]
      values.each do |invalid_value|
        @book.count = invalid_value
        @book.should_not be_valid
      end
    end
  end

  describe "when count format is valid" do
    it "should be invalid" do
      values = [2,20,100,0]
      values.each do |valid_value|
        @book.count = valid_value
        @book.should be_valid
      end
    end
  end
end