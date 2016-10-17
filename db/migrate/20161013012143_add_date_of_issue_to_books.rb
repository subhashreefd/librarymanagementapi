class AddDateOfIssueToBooks < ActiveRecord::Migration
  def change
    add_column :books, :DateOfIssue, :date
  end
end
