class AddCategoryToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :category, :string
  end
end
