class ActivitiesController < ApplicationController
  before_filter :require_user

  def index
    @activities = current_space.activities.limit(50)
  end
end
