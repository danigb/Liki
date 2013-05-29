class TrackActivityWorker
  include Sidekiq::Worker

  def perform(action, trackable, user)
    Activity.track(action, trackable, user)
  end
end
