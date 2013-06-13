module EventHelper
  def month_name(month)
    I18n.t("date.month_names")[month].camelcase
  end

  def day_label(date)
    name = I18n.t('date.day_names')[date.wday].camelcase
    "#{name} #{l(date)}"
  end
end
