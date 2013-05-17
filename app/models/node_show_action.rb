
class NodeShowAction
  attr_reader :node 
  attr_reader :redirect, :redirect_params

  def initialize(space, user)
    @space = space
    @user = user
  end

  def has_better_id?
    return @found_by_id
  end

  def show(id_or_slug)
    if @node = find_by_id(id_or_slug)
      @found_by_id = true
      @redirect = @node.parent
      @redirect_params = { anchor: @node.id }
    elsif @node = find_by_slug(id_or_slug)
      @found_by_id = false
      update_view_count
    end
  end

  protected 
  def update_view_count
    Access.get(@node, @user).view!

    @node.view_count = @node.view_count + 1
    @node.save
  end


  def find_by_id(id_or_slug)
    @space.nodes.find(id_or_slug) if id_or_slug =~ /^\d+$/
  end

  def find_by_slug(id_or_slug)
    @space.nodes.find_by_slug(id_or_slug)
  end
end
