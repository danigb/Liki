module HasMentions
  extend ActiveSupport::Concern

  included do
    has_many :mentioned, 
      foreign_key: 'to_id', class_name: 'Mention',
      dependent: :delete_all
    has_many :mentions, 
      foreign_key: 'from_id', dependent: :delete_all
    has_many :mentioned_nodes, 
      class_name: 'Node', through: :mentions,
      source: :to
    has_many :mentioned_by_nodes, 
      class_name: 'Node', through: :mentioned,
      source: :from
  end

  def mentioner
    @mentioner ||= Mentioner.new(self)
  end
end
