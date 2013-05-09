module ApplicationHelper

  def title(title)
    content_for(:title) { title }
    content_tag :h1, title
  end

  def icon(icon, label = nil)
    label = label.present? ? h("#{label}") : ''
    raw("<i class='icon-#{icon}'></i>&nbsp;#{label}")
  end

  def format_body(text)
    raw Rinku.auto_link(simple_format(text))
  end

  def boolean_input(name, label)
    content_tag :div, class: 'input boolean' do
      check_box_tag(name) + content_tag(:label, label)
    end
  end

end
