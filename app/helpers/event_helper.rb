module EventHelper
  def event_calendar_path(event)
    calendar_path(y: event.date.year, m: event.date.month)
  end

  def view_event_path(event)
    if event.node
      node_event_path(event.node)
    else
      event_path(event)
    end
  end

  def month_name(month)
    I18n.t("date.month_names")[month].camelcase
  end

  def day_label(date)
    name = I18n.t('date.day_names')[date.wday].camelcase
    "#{name} #{l(date)}"
  end
end
