class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :user
      t.integer :sender_id
      t.integer :receiver_id
      t.references :marketpost
      t.text :description
      t.boolean :sender_read, :default => false, :null => false
      t.boolean :receiver_read, :default => false, :null => false
      t.boolean :hidden_transaction, :default => false, :null => false
      t.timestamps
    end
    add_index :transactions, :user_id
    add_index :transactions, :marketpost_id
  end
end
