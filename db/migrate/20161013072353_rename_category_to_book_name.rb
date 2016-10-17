class RenameCategoryToBookName < ActiveRecord::Migration
  def change
  	rename_column :authors, :category, :book_name
  end
end
