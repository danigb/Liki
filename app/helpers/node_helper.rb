module NodeHelper 
  class LikiRender < Redcarpet::Render::HTML
    def header(text, header_level)
      "<h3>#{text}</h3>"
    end
  end
  
  def main_node?(node)
    node.parent.blank? || current_page?(node)
  end

  def old_format_body(text)
    raw Rinku.auto_link(simple_format(text))
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

end
