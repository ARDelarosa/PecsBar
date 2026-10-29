module Management
  class Management::DailySpecialsController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_daily_special, only: [:edit, :update]

    def index
      @daily_specials = DailySpecial.order(:day_of_week)
    end

    def new
      @daily_special = DailySpecial.new
    end

    def create
      @daily_special = DailySpecial.new(daily_special_params)

      if @daily_special.save
        redirect_to management_daily_specials_path, 
          notice: "Daily Special created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @daily_special.update(daily_special_params)
        redirect_to management_daily_specials_path, 
          notice: "Daily Special updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_daily_special
      @daily_special = DailySpecial.find(params[:id])
    end

    def daily_special_params
      params.require(:daily_special).permit(
        :day_of_week,
        :title,
        :description,
        :happy_hour_start,
        :happy_hour_end,
        :active
      )
    end

  end
end
