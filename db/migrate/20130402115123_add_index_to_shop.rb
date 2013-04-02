class AddIndexToShop < ActiveRecord::Migration
  def change
    add_index :shops, :url
  end
end
