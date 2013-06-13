class EventsController < ApplicationController
  respond_to :html
  before_filter :require_user

  def index
    @month = (params[:month] || Time.zone.now.month).to_i
    @year = (params[:year] || Time.zone.now.year).to_i
    @shown_month = Date.civil(@year, @month)
    @events = Event.in_month(@year, @month)
  end

  def create
    event = Event.new(event_params)
    event.space = current_space
    event.user = current_user
    event.save
    redirect_to events_path
  end

  protected
  def event_params
    params.require(:event).permit(:name, :date, :time)
  end
end
