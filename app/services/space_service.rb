class SpaceService
  attr_reader :space

  def initialize(space)
    @space = space
  end

  def regenerate_counters
    Space.reset_counters(space.id, :nodes, :mentions, :members)
  end

  def regenerate_mentions
    space.mentions.destroy_all
    Space.reset_counters(space.id, :mentions)
  #  space.nodes.find_each do |node|
  #    MentionService.update_mentions(node)
  #  end
  end

end
