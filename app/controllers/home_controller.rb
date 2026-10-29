class HomeController < ApplicationController
  def index
    today = Date.current.strftime("%A").downcase

    @daily_special = DailySpecial
      .where(active: true)
      .find_by(day_of_week: DailySpecial.day_of_weeks[today])
  end
end