class CreateDailySpecials < ActiveRecord::Migration[8.1]
  def change
    create_table :daily_specials do |t|
      t.integer :day_of_week,  null: false
      t.string :title, null: false
      t.text :description
      t.time :happy_hour_start
      t.time :happy_hour_end
      t.boolean :active, default: true, null: false

      t.timestamps
    end
  end
end
