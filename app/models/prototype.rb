class Prototype < ActiveRecord::Base
  belongs_to :space
  belongs_to :children, class_name: 'Prototype'
  has_many :nodes

  attr_accessor :node

  include FriendlyId
  friendly_id :name, use: :scoped, scope: :space

  validates_presence_of :name, :space_id
  validates_uniqueness_of :name, scope: :space_id

  ORDERS = { 
    'alphabetically' => 'title ASC',
    'inserted' => 'created_at ASC',
    'last_first' => 'created_at DESC',
    'position' => 'position ASC'
  }

  def order(collection)
    sql = ORDERS[order_options] || 'title ASC'
    collection.reorder(sql)
  end
end
