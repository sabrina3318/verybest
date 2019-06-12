class CreateDishes < ActiveRecord::Migration[5.1]
  def change
    create_table :dishes do |t|
      t.integer :cuisine_id
      t.string :name

      t.timestamps
    end
  end
end
