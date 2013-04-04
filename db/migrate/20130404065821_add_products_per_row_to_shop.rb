class AddProductsPerRowToShop < ActiveRecord::Migration
  def change
    add_column :shops, :products_per_row, :integer
  end
end
