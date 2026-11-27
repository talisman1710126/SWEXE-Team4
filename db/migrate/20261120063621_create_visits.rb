class CreateVisits < ActiveRecord::Migration[8.1]
  def change
    create_table :visits do |t|
      t.references :user, null: false
      t.references :spot, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.datetime :visited_at

      t.timestamps
    end

    add_index :visits, [ :user_id, :spot_id ], unique: true
  end
end
