module HasMembers
  extend ActiveSupport::Concern

  included do
    has_many :members
    has_many :users, through: :members
  end

  # Get the Member object for this user
  # Always present if space is_open?
  def member(user)
    return unless user.present?
    is_open? ? add_member(user) : get_member(user)
  end

  def add_member(user)
    return unless user.present?
    m = get_member(user)
    m ||= Member.create(space: self, user: user)
  end

  protected
  def get_member(user)
    Member.where(space_id: self.id, user_id: user.id).first
  end
end
