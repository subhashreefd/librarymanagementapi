class AddDateOfReturnToBooksOnLoans < ActiveRecord::Migration
  def change
    add_column :books_on_loans, :DateOfReturn, :date
  end
end
