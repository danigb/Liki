class TrackActivityWorker
  include Sidekiq::Worker

  def perform(action, trackable_type, trackable_id, user_id)
    user = User.where(id: user_id).first
    trackable = find(trackable_type, trackable_id)
    Activity.track(action, trackable, user)
  end

  private
  def find(trackable_type, trackable_id)
    trackable_type.constantize.where(id: trackable_id).first
  end
end
