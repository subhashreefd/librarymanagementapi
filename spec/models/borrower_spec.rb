require 'spec_helper'

describe Borrower do

  before do
    @borrower = Borrower.new(name: "Example User", email: "user@example.com")
  end
  
  describe "#create" do
    it "creates a successful borrower" do
      @borrowertest = Borrower.create(name: "Example User", email: "user@example.com")
      @borrowertest.should be_an_instance_of Borrower
    end
  end

  subject { @borrower }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should be_valid }

  describe "when  name cannot be empty" do
    before { @borrower.name = " " }
    it { should_not be_valid }
  end
 
  
  describe "when name is too long" do
    before { @borrower.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when name is within limit" do
    before { @borrower.name = "a" * 50 }
    it { should be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @borrower.email = invalid_address
        @borrower.should_not be_valid
      end
    end
  end
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @borrower.email = valid_address
        @borrower.should be_valid
      end
    end
  end
  describe "when email address is already taken" do
    before do
      borrower_with_same_email = @borrower.dup
      borrower_with_same_email.email = @borrower.email.upcase
      borrower_with_same_email.save
    end

    it { should_not be_valid }
  end
end