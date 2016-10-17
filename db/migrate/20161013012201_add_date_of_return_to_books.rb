class AddDateOfReturnToBooks < ActiveRecord::Migration
  def change
    add_column :books, :DateOfReturn, :date
  end
end
