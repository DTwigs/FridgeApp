class CreateTemperatures < ActiveRecord::Migration
  def change
    create_table :temperatures do |t|
      t.integer :temperature, null: false, default: 0
      t.timestamps
    end
  end
end
