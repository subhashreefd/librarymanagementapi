class CreateBooksOnLoans < ActiveRecord::Migration
  def change
    create_table :books_on_loans do |t|
      t.integer :book_id
      t.integer :borrower_id

      t.timestamps
    end
  end
end
