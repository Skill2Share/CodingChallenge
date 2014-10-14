class CreateMarketposts < ActiveRecord::Migration
  def change
    create_table :marketposts do |t|
      t.string :title
      t.text :message
      t.references :user
      t.boolean :hidden_marketpost, :default => false, :null => false
      t.timestamps

    end
    add_index :marketposts, :user_id
  end
end
