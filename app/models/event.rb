class Event < ActiveRecord::Base
  belongs_to :space
  belongs_to :user
  belongs_to :node

  validates_presence_of :space_id, :user_id, :name, :date

  def self.month_scope(relation, year, month)
    first_day = Date.civil(year, month, 1)
    last_day = Date.civil(year, month + 1) - 1.day
    relation.where("date >= ?", first_day).
      where("date <= ?", last_day).
      order('date ASC')
  end

end
