class User < ActiveRecord::Base
  has_many :members
  has_many :nodes

  include FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :name
end
