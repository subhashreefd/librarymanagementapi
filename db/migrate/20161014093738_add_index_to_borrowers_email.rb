class AddIndexToBorrowersEmail < ActiveRecord::Migration
  def change
  	def change
    add_index :borrowers, :email, unique: true
  end
  end
end
