module HasMembers
  extend ActiveSupport::Concern

  included do
    has_many :members
    has_many :users, through: :members
  end

  def member(user)
    Member.where(space_id: self.id, user_id: user.id).first if user
  end

  def add_member(user)
    return unless user.present?
    m = member(user)
    m ||= Member.create(space: self, user: user)
  end
end
