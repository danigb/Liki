class Prototype < ActiveRecord::Base
  belongs_to :space
  
  attr_accessor :node

  include FriendlyId
  friendly_id :name, use: :scoped, scope: :space

  validates_presence_of :name, :space_id
  validates_uniqueness_of :name, scope: :space_id

  def order(collection)
    collection.reorder('title ASC')
  end
end
