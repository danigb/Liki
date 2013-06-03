module ApplicationHelper

  def title(title)
    content_for(:title) { title }
    content_tag :h1, title
  end

  def icon(icon, label = nil)
    label = label.present? ? h("#{label}") : ''
    raw("<i class='icon-#{icon}'></i>&nbsp;#{label}")
  end

  def boolean_input(name, label)
    content_tag :div, class: 'input boolean' do
      check_box_tag(name) + content_tag(:label, label)
    end
  end

  def truncate_html(text, options = {})
    return unless text.present?
    Truncato.truncate(text, max_length: 400).html_safe
  end

  def flash_class(name)
    name == :notice ? 'success' : 'error'
  end

end
