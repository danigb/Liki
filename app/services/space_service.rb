class SpaceService
  attr_reader :space

  def initialize(space)
    @space = space
  end

  def regenerate_counters
    Space.reset_counters(space.id, :nodes, :mentions, :members)
    space.nodes.pluck(:id).each do |node_id|
      Node.reset_counters node_id, :children
    end
  end

  def regenerate_mentions
    Mention.destroy_all
    space.nodes.find_each do |node|
      node.mentioner.update_mentions
    end
  end

end
