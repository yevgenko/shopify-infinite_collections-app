class AddScriptStatusToShop < ActiveRecord::Migration
  def change
    add_column :shops, :script_installed, :boolean
  end
end
