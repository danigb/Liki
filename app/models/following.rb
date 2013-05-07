class Following < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :followed, polymorphic: true, counter_cache: :followers_count

  validates_presence_of :user_id, :followed_id, :followed_type

  def self.follow(model, user)
    return unless model && user
    following = Following.following(model, user)
    following ||= Following.create(user_id: user.id, followed_id: model.id,
                                   followed_type: model.class.to_s)
  end

  def self.following(model, user)
    return unless model && user
    Following.where(user_id: user.id, followed_id: model.id,
                    followed_type: model.class.to_s).first
  end
end
