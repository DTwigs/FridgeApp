class CreateTemperatures < ActiveRecord::Migration[5.0]
  def change
    create_table :temperatures do |t|
      t.integer :temperature, null: false, default: 0
      t.timestamps
    end
  end
end
