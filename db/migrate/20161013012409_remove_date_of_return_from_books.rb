class RemoveDateOfReturnFromBooks < ActiveRecord::Migration
  def up
    remove_column :books, :DateOfReturn
  end

  def down
    add_column :books, :DateOfReturn, :date
  end
end
