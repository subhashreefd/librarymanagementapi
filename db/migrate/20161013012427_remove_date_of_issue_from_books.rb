class RemoveDateOfIssueFromBooks < ActiveRecord::Migration
  def up
    remove_column :books, :DateOfIssue
  end

  def down
    add_column :books, :DateOfIssue, :date
  end
end
