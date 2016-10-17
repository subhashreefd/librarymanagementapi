class RemoveIsbnFromBooks < ActiveRecord::Migration
  def up
    remove_column :books, :isbn
  end

  def down
    add_column :books, :isbn, :string
  end
end
