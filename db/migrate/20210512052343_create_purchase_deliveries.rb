class CreatePurchaseDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_deliveries do |t|

      t.timestamps
    end
  end
end
