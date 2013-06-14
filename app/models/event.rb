class Event < ActiveRecord::Base
  belongs_to :space
  belongs_to :user
  has_many :nodes, dependent: :nullify
  attr_accessor :node_id

  validates_presence_of :space_id, :user_id, :name, :date
  after_save :add_to_node_id

  def self.month_scope(relation, year, month)
    first_day = Date.civil(year, month, 1)
    last_day = Date.civil(year, month + 1) - 1.day
    relation.where("date >= ?", first_day).
      where("date <= ?", last_day).
      order('date ASC')
  end

  def add_to_node(node)
    node.update_attributes(event_id: self.id) if node.space_id == self.space_id
  end

  protected
  def add_to_node_id
    self.add_to_node(space.nodes.find(self.node_id)) if self.node_id.present?
  end

end
