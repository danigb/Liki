class CalendarPresenter < SimpleDelegator
  attr_reader :options
  attr_reader :first, :last
  attr_reader :events

  def initialize(view, events, opts)
    super(view)

    defaults = {
      first_day_of_week: 1
    }
    @options = defaults.merge(opts)
    @events = events

    @first = Date.civil(options[:year], options[:month], 1)
    @last = Date.civil(options[:year], options[:month], -1)
    @today = Time.zone.now.to_date
  end

  def render_calendar
    begin_of_week = beginning_of_week(first, options[:first_day_of_week])
    all = events.to_a.dup
    begin_of_week.upto(last) do |current|
      events = events_for(all, current)
      yield current, events
    end
  end

  def title
    month_name = I18n.t("date.month_names")[options[:month]]
    "#{month_name.camelcase} #{options[:year]}"
  end

  def display?(day)
    day.month == options[:month]
  end

  def day_class(day)
    'day-today' if day == @today
  end

  protected
  def events_for(all, current)
    events = []
    while all.first.try(:date) == current
      events << all.shift
    end
    events
  end

  def beginning_of_week(date, start = 1)
    days_to_beg = days_between(start, date.wday)
    date - days_to_beg
  end

  def days_between(first, second)
    if first > second
      second + (7 - first)
    else
      second - first
    end
  end
end
