class CreatePrefectures < ActiveRecord::Migration[6.0]
  def change
    create_table :prefectures do |t|
      t.integer :prefecture_id
      t.string :city

      t.timestamps
    end
  end
end
