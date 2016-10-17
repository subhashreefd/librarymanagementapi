class RemoveBookNameFromAuthors < ActiveRecord::Migration
  def up
    remove_column :authors, :book_name
  end

  def down
    add_column :authors, :book_name, :string
  end
end
