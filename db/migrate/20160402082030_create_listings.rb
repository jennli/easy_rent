class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.string :pic_1
      t.integer :monthly_rate
      t.integer :daily_rate
      t.string :address
      t.string :city
      t.string :province
      t.string :country
      t.float :longitude
      t.float :latitude
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
