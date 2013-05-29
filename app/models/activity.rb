class Activity < ActiveRecord::Base
  belongs_to :space
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  validates_presence_of :user_id, :action,
    :trackable, :trackable_type, :space_id

  def self.track(action, model, user)
    return unless action && model && user
    activity = Activity.where(action: action, user_id: user.id, 
                              space_id: model.space_id,
                              trackable_id: model.id, 
                              trackable_type: model.class.name).first
    if activity
      activity.touch
    else
      activity = Activity.create!(action: action, user: user, 
                                 space: model.space, trackable: model)
    end
    activity
  end
end
