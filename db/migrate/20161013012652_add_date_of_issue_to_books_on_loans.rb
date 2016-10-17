class AddDateOfIssueToBooksOnLoans < ActiveRecord::Migration
  def change
    add_column :books_on_loans, :DateOfIssue, :date
  end
end
