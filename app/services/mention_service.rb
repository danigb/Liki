module MentionService
  def update_mentions(node)
    node.mentions.destroy_all

    mentions_solved = true
    Linkify.links(node.body) do |tag, name, param|
      if mentioned = node.space.nodes.where(slug: param).first
        Mention.mention(node, mentioned) 
      else
        mentions_solved = false
      end
    end
    node.update_column(:mentions_solved, mentions_solved)
  end

  extend self
end
