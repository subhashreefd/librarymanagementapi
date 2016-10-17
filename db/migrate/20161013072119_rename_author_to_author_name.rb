class RenameAuthorToAuthorName < ActiveRecord::Migration
  def change
    rename_column :books, :author, :author_name
  end
end
