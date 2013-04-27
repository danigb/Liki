class User < ActiveRecord::Base
  include FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :name
end
