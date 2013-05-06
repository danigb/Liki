class Mention < ActiveRecord::Base
  belongs_to :from, class_name: 'Node', counter_cache: :mentions_count
  belongs_to :to, class_name: 'Node', counter_cache: :mentioned_count
  belongs_to :group, counter_cache: true

  validates_presence_of :from_id, :to_id, :group_id

  def self.mention(from, to)
    raise Exception.new('group id does not match') if from.group_id != to.group_id
    mention = Mention.where(from_id: from.id, to_id: to.id, group_id: from.group_id).first
    mention ||= Mention.create(from: from, to: to, group: from.group)
  end
end
