class EventsController < ApplicationController
  def index
    @events = Event.order(event_date: :asc)

    @current_month = if params[:month].present?
      Date.strptime(params[:month], "%Y-%m").beginning_of_month
    else
      Date.current.beginning_of_month
    end

    @next_month = @current_month.next_month
    @previous_month = @current_month.prev_month

    calendar_start = @current_month.beginning_of_week(:sunday)
    calendar_end = @current_month.end_of_month.end_of_week(:sunday)

    @calendar_days = (calendar_start..calendar_end).to_a
    @events_by_date = @events.group_by(&:event_date)
  end

  def show
    @event = Event.find(params[:id])
  end
end