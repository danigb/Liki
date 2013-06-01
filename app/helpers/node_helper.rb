module NodeHelper 
  def node_image(node)
    node.image.url || node.dropbox_image_url
  end

  def image_source(node)
    node.image.url ? 'local' : 'remote'
  end

  def main_node?(node)
    node.parent.blank? || current_page?(node)
  end

  def children_name(node)
    node.children_name? ? node.children_name : 'página'
  end

  def cancel_form_node_path(node)
    if !node.new_record?
      node_path(node)
    elsif node.parent
      node_path(node.parent)
    else
      root_path
    end
  end

end
