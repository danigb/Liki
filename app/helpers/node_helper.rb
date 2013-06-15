module NodeHelper 
  def render_body(node, options = {})
    return unless node.body.present?
    text = options[:length] ?
      HTML_Truncator.truncate(node.body, 40) :
      node.body

    text = Linkify.links(text) do |tag, name, param|
      link_to(name, node_path(param), class: 'linkify')
    end

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
