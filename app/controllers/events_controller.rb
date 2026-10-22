class EventsController < ApplicationController
  before_action :authenticate_admin!,
    except: [:index, :show]
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

  def new
    @event = Event.new
  end

  
  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to(
        admin_return_path || event_path(@event),
        notice: "Event created successfully."
      )
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to(
        admin_return_path || event_path(@event),
        notice: "Event updated successfully."
      )
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to(
      admin_return_path || events_path,
      notice: "Event deleted successfully."
    )
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :event_date, :start_time, :end_time, :flyer)
  end

end