module HasComments
  extend ActiveSupport::Concern

  included do
    has_many :comments, -> { order('created_at ASC') }, 
      dependent: :delete_all
  end

  def comment(user, params) 
    params.reverse_merge!(user: user, node: self)
    Comment.create!(params)
  end
end
