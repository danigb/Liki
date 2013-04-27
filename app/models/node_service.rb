
class NodeService
  def self.add_children(text, parent, user)
    return if text.blank?
    attrs = { parent: parent, user: user }
    lines = text.split /\n/
    if lines.count > 2 && lines[1] == ''
      attrs[:title] = lines[0]
      attrs[:body] = lines[2..-1].join "\n"
    else
      attrs[:body] = text
    end
    Node.create(attrs)
  end
end
