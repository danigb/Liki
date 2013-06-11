class Prototype < ActiveRecord::Base
  belongs_to :space
  
  attr_accessor :node

  include FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :space_id

  def order(collection)
    collection.reorder('title ASC')
  end
end
