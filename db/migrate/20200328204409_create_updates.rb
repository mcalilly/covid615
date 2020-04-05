class CreateUpdates < ActiveRecord::Migration[6.0]
  def change
    create_table :updates do |t|
      t.belongs_to :county, null: false, foreign_key: true
      t.date :date
      t.integer :cases
      t.integer :deaths
      t.integer :total_cases
      t.integer :total_deaths
      t.decimal :new_cases_growth_rate, precision: 5, scale: 2
      t.decimal :total_cases_growth_rate, precision: 5, scale: 2
      t.decimal :new_deaths_growth_rate, precision: 5, scale: 2
      t.decimal :average_death_rate, precision: 5, scale: 2

      t.timestamps
    end
  end
end
