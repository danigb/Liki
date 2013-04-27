class Group < ActiveRecord::Base
  has_one :node
  has_many :members
  has_many :users, through: :members
  has_many :nodes

  validates_presence_of :name
end
