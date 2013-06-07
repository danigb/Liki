module HasActivity
  extend ActiveSupport::Concern

  included do
    has_many :activities, as: :trackable,
      dependent: :delete_all
  end

end
