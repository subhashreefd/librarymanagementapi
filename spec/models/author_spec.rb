require 'spec_helper'



describe Author do

  before { @author = Author.new(:name => "example name", :category => "examplecategory") }
  subject { @author }

  it { should respond_to(:name) }
  it { should respond_to(:category) }
  it { should be_valid }
  
  describe "when author name cannot be empty" do
    before { @author.name = " " }
    it { should_not be_valid }
  end
 

  describe "when category name canot be empty" do
    before { @author.category = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @author.name = "a" * 51 }
    it { should_not be_valid }
  end

end