class Book < ActiveRecord::Base
  attr_accessible :author_name, :count, :category, :onloan, :title, :author_id
  validates :title, :presence => true
  validates :category, :presence => true
  validates :count,:numericality => { :greater_than_or_equal_to => 0 ,
                                      only_integer: true },:presence => true
  belongs_to :author
  has_many  :borrowers
  has_many :books_on_loans

end
