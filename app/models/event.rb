class Event < ActiveRecord::Base
  belongs_to :space
  belongs_to :user
  belongs_to :node

  validates_presence_of :space_id, :user_id, :name, :date

  def self.in_month(year, month)
    first_day = Date.civil(year, month, 1)
    last_day = Date.civil(year, month + 1) - 1.day
    Event.where("date >= ?", first_day).where("date <= ?", last_day)
  end

end
