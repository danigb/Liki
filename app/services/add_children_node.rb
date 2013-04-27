
class AddChildrenNode
  attr_accessor :node

  def initialize(content, parent, user)
    params = { parent: parent, user: user }
    if content.present?
      lines = content.split /\n+/
      params[:title] = lines[0]
      params[:body] = lines[1..-1].join "\n"
    end
    @node = Node.new(params)
  end

  def save
    @node.save
  end
end
