class Mentioner
  def initialize(node)
    @node = node
  end

  def update_mentions
    @node.mentions.destroy_all
    extracted = Mentioner.extract_mentions(@node.body)
    extracted.each do |name|
      slug = name[1..-1].underscore.gsub(/_/, '-')
      mentioned = Node.find_by_slug slug
      Mention.mention(@node, mentioned) if mentioned
    end
    @node.update_columns(mentions_solved: @node.mentions.count == extracted.size)
  end

  MENTIONS = /(?:^|\s)(?:#)[^\s^:^.^,^<^"^(^)]+/
  def self.extract_mentions(text)
    return [] if text.blank?
    text.scan(MENTIONS).map &:lstrip
  end
end
