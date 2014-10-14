class AddPostTypeToMarketposts < ActiveRecord::Migration
  def change
    add_column :marketposts, :post_type, :string, default: 'request'
  end
end
