class RemoveBookIdToAuthors < ActiveRecord::Migration
  def up
    remove_column :authors, :book_id
  end

  def down
    add_column :authors, :book_id, :integer
  end
end
