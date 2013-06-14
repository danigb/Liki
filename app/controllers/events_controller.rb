class EventsController < ApplicationController
  respond_to :html
  before_filter :require_user

  def index
    @month = (params[:m] || Time.zone.now.month).to_i
    @year = (params[:y] || Time.zone.now.year).to_i
    @shown_month = Date.civil(@year, @month)
    @events = Event.month_scope(current_space.events, @year, @month)
  end

  def show
    respond_with event
  end

  def new
    @event = Event.new(date: params_date)
    respond_with @event
  end

  def edit
    respond_with event
  end

  def create
    @event = Event.new(event_params)
    @event.space = current_space
    @event.user = current_user
    @event.save
    respond_with @event, location: event_path(@event)
  end

  def update
    event.attributes = event_params
    flash.notice = 'Evento guardado.' if event.save
    redirect_to events_path
  end

  def destroy
    flash.notice = 'Evento borrado.' if event.destroy
    redirect_to events_path
  end

  protected
  def params_date
    begin
      Date.civil(params[:y].try(:to_i), 
                 params[:m].try(:to_i), 
                 params[:d].try(:to_i))
    rescue Exception
    end
  end

  def event
    @event ||= current_space.events.find params[:id]
  end

  def event_params
    params.require(:event).permit(:name, :date, :time, :node_id)
  end

  def event_path(event)
    if event && event.date
      calendar_path(y: event.date.year, m: event.date.month)
    else
      calendar_path
    end
  end
end
