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
    if event
      respond_with event
    else
      redirect_to [:new, @node, :event]
    end
  end

  def new
    @event = Event.new(date: params_date, node: node)
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
    redirect_to event_path(event)
  end

  def destroy
    flash.notice = 'Evento borrado.' if event.destroy
    redirect_to event_path(event)
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

  def node
    if params[:node_id]
      @node ||= current_space.nodes.find params[:node_id]
    end
  end

  def event
    if node
      @event ||= node.event
    else
      @event ||= current_space.events.find params[:id]
    end
  end

  def event_params
    params.require(:event).permit(
      :name, :date, :body, :time, :node_id)
  end

  def event_path(event)
    if event && event.date
      calendar_path(y: event.date.year, m: event.date.month)
    else
      calendar_path
    end
  end
end
