class CreateCounties < ActiveRecord::Migration[6.0]
  def change
    create_table :counties do |t|
      t.string :name
      t.integer :fips
      t.belongs_to :state, null: false, foreign_key: true
      t.integer :total_cases
      t.integer :total_deaths
      t.decimal :death_rate, precision: 5, scale: 2

      t.timestamps
    end
  end
end
