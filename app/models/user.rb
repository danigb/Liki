class User < ActiveRecord::Base
  has_many :members
  has_many :nodes
  has_many :followings, -> { order('created_at DESC') }

  include FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :name
end
