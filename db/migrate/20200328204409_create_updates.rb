class CreateUpdates < ActiveRecord::Migration[6.0]
  def change
    create_table :updates do |t|
      t.belongs_to :county, null: false, foreign_key: true
      t.integer :fips
      t.date :date
      t.string :source
      t.integer :cases
      t.integer :deaths

      t.timestamps
    end
  end
end
