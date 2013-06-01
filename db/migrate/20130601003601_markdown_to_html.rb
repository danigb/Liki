class MarkdownToHtml < ActiveRecord::Migration
  class LikiRender < Redcarpet::Render::HTML
    def header(text, header_level)
      "<h3>#{text}</h3>"
    end
  end

  def change
    ActiveRecord::Base.record_timestamps = false
    options = {hard_wrap: true, autolink: true, fenced_code_blocks: true }
    renderer = Redcarpet::Markdown.new(LikiRender, options)
    Node.find_each do |node|
      node.update_attributes(body: renderer.render(node.body))
    end
  end
end
