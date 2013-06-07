module HasFollowers
  extend ActiveSupport::Concern

  included do
    has_many :followings, as: :followed, dependent: :delete_all
    has_many :followers, through: :followings, source: :user, class_name: 'User'
  end
end
