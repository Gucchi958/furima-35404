class CreateCharges < ActiveRecord::Migration[6.0]
  def change
    create_table :charges do |t|
      t.integer :charge_id
      t.string :charge

      t.timestamps
    end
  end
end
