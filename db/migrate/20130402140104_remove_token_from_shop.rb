class RemoveTokenFromShop < ActiveRecord::Migration
  def up
    remove_column :shops, :token
  end

  def down
    add_column :shops, :token, :string
  end
end
