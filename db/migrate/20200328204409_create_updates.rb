class CreateUpdates < ActiveRecord::Migration[6.0]
  def change
    create_table :updates do |t|
      t.belongs_to :county, null: false, foreign_key: true
      t.date :date
      t.string :source
      t.integer :cases
      t.integer :deaths
      t.decimal :case_growth_rate, precision: 5, scale: 2
      t.decimal :death_growth_rate, precision: 5, scale: 2

      t.timestamps
    end
  end
end
