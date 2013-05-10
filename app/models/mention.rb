class Mention < ActiveRecord::Base
  belongs_to :from, class_name: 'Node', counter_cache: :mentions_count
  belongs_to :to, class_name: 'Node', counter_cache: :mentioned_count
  belongs_to :space, counter_cache: true

  validates_presence_of :from_id, :to_id, :space_id

  def self.mention(from, to)
    raise Exception.new('space id does not match') if from.space_id != to.space_id
    mention = Mention.where(from_id: from.id, to_id: to.id, space_id: from.space_id).first
    mention ||= Mention.create(from: from, to: to, space: from.space)
  end
end
