class CreateFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :features do |t|
      t.float :mag
      t.string :place, null: false
      t.integer :time
      t.string :url, null: false
      t.integer :tsunami
      t.string :magType, null: false
      t.string :title, null: false
      t.float :longitude, null: false
      t.float :latitude, null: false
      t.float :magnitude, null: false
      t.string :externalId

      t.timestamps
    end
  end
end
