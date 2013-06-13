module NodeHelper 
  def render_body(node, options = {})
    return unless node.body.present?
    text = options[:length] ?
      # Truncato.truncate(node.body, max_length: options[:length]) : 
      HTML_Truncator.truncate(node.body, 40) :
      node.body

    Rinku.auto_link(
      text, :urls, 'target="_blank" rel="nofollow"').html_safe
  end

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
    node.proto.children.try(:name)
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
