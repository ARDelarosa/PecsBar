class AddUniqueDayIndexToDailySpecials < ActiveRecord::Migration[8.1]
  def change
    add_index :daily_specials, :day_of_week, unique: true
  end
end
