module MapHelper
  def children_map_data(node)
    node.descendants.to_gmaps4rails
  end
end
