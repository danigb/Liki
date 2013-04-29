class Mention < ActiveRecord::Base
  belongs_to :from, class_name: 'Node', counter_cache: :mentions_count
  belongs_to :to, class_name: 'Node', counter_cache: :mentioned_count

  validates_presence_of :from_id, :to_id

  def self.mention(from, to)
    mention = Mention.where(from_id: from.id, to_id: to.id).first
    mention ||= Mention.create(from: from, to: to)
  end
end
