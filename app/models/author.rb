class Author < ActiveRecord::Base

  attr_accessible :category, :name
  validates :name,:presence => true,length: { maximum: 50 }
  validates :category, :presence => true

  has_many :books, dependent: :destroy
end
