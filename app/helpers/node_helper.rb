module NodeHelper 

  def node_image(node)
    node.image.url || node.dropbox_image_url
  end

  def image_source(node)
    node.image.url ? 'local' : 'remote'
  end

  class LikiRender < Redcarpet::Render::HTML
    def header(text, header_level)
      "<h3>#{text}</h3>"
    end
  end

  def simple_format_body(text)
    raw Rinku.auto_link(simple_format(text))
  end

  def main_node?(node)
    node.parent.blank? || current_page?(node)
  end

  def format_body(text)
    markdown_renderer.render(text).html_safe
  end

  def markdown_renderer
    unless @renderer
      options = {hard_wrap: true, autolink: true, fenced_code_blocks: true }
      @renderer = Redcarpet::Markdown.new(LikiRender, options)
    end
    @renderer
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
