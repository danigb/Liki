
class NodeService
  def self.move_to(node, parent_id)
    parent_id = nil if parent_id == -1
    node.update_attributes(parent_id: parent_id)
  end
  def self.reorder_children(node)
    node.children.each_with_index do |n,i|
      n.update_columns(position: i + 1)
    end
  end

  def self.add_children(text, parent, user)
    return if text.blank?
    Node.create( { parent: parent, user: user }.
                merge(parse(text)))
  end

  def self.parse(text)
    lines = text.lines.to_a
    if lines.count > 2 && lines[1].blank? && lines[0].length < 50
      { title: lines[0].gsub(/\r\n|\r|\n/, ''),
        body: lines[2..-1].join("\n")}
    else
      { body: text }
    end
  end

  def self.update_mentions(node)
    node.mentions.destroy_all
    extracted = extract_mentions(node.body)
    extracted.each do |name|
      slug = name[1..-1].underscore.gsub(/_/, '-')
      mentioned = Node.find_by_slug slug
      Mention.mention(node, mentioned) if mentioned
    end
    node.update_columns(mentions_solved: true) if node.mentions.count == extracted.size
  end

  MENTIONS = /\s(?:#|@)[^\s^:^.^,^<^"^(^)]+/
  def self.extract_mentions(text)
    return [] if text.blank?
    text.scan(MENTIONS).map &:lstrip
  end
end
