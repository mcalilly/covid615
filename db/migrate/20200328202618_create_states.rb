class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.string :name
      t.integer :fips
      t.integer :total_cases
      t.integer :total_deaths
      t.integer :death_rate
  
      t.timestamps
    end
  end
end
