
class NodeService
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
end
