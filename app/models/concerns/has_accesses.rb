module HasAccesses
  extend ActiveSupport::Concern

  included do
    has_many :accesses, dependent: :delete_all
  end

  def access(user)
    return unless user.present?
    access = Access.where(node_id: self.id, user_id: user.id).first
    access ||= Access.create(node: self, user: user)
  end
end
