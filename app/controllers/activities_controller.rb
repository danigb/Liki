class ActivitiesController < ApplicationController
  before_filter :require_user

  def index
    @activities = current_space.activities.
      where(action: 'create').
      order('created_at DESC').
      limit(50)
  end
end
