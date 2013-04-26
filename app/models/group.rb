class Group < ActiveRecord::Base
  has_one :node
  has_many :members
  has_many :users, through: :members

  validates_presence_of :name
end
