class ActivityReportPresenter < SimpleDelegator
  def initialize(activities, view)
    super(view)
    @activities = activities
    @report = {}
  end

  def render_report
    @activities.each do |a|
      add_to_day(time_ago_in_words(a.created_at), a)
    end
    render 'activities/report', report: @report
  end

  def add_to_day(key, value)
    @report[key] ||= []
    @report[key] << value
  end
end
