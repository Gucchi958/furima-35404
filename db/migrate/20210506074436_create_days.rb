class CreateDays < ActiveRecord::Migration[6.0]
  def change
    create_table :days do |t|
      t.integer :day_id
      t.string :day

      t.timestamps
    end
  end
end
