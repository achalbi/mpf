class CreateMps < ActiveRecord::Migration
  def change
    create_table :mps do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :country
      t.string :continent
      t.float :geoX
      t.float :geoY

      t.timestamps null: false
    end
    add_index :mps, :city
    add_index :mps, :country
    add_index :mps, :continent
  end
end
