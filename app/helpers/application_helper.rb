module ApplicationHelper

  def title(title)
    content_for(:title) { title }
    content_tag :h1, title
  end

  def icon(icon, label = nil)
    label = label.present? ? h("#{label}") : ''
    raw("<i class='icon-#{icon}'></i>&nbsp;#{label}")
  end
end
