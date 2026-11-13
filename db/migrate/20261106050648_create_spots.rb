class CreateSpots < ActiveRecord::Migration[8.1]
  def change
    create_table :spots do |t|
      t.string :name_ja
      t.string :name_en
      t.integer :category
      t.text :description_en
      t.string :access
      t.decimal :latitude, precision: 10, scale: 7
      t.decimal :longitude, precision: 10, scale: 7

      t.timestamps
    end
  end
end
