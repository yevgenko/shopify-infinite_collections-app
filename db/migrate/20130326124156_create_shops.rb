class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :url
      t.string :token
      t.boolean :paid

      t.timestamps
    end
  end
end
