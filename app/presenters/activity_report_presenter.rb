class ActivityReportPresenter < SimpleDelegator
  def initialize(activities, view)
    super(view)
    @activities = activities
    @report = {}
  end

  def render_report
    @activities.each do |a|
      add_to_day(l(a.created_at.to_date), a)
    end
    render 'activities/report', report: @report
  end

  def add_to_day(key, activity)
    if activity.trackable
      @report[key] ||= []
      @report[key] << activity 
    end
  end
end
