module ApplicationHelper

  def title(title)
    content_for(:title) { "#{title} :: #{current_space.name}" }
    content_tag :h1, title
  end

  def icon(icon, label = nil)
    label = label.present? ? h("#{label}") : ''
    raw("<i class='icon-#{icon}'></i>&nbsp;#{label}")
  end

  def arrow(label)
    icon('arrow-right', label)
  end

  def boolean_input(name, label)
    content_tag :div, class: 'input boolean' do
      check_box_tag(name) + content_tag(:label, label)
    end
  end

  def flash_class(name)
    name == :notice ? 'success' : 'error'
  end

  def toggle_link(name, css_class)
    link_to name, '#', data: { toggle: css_class }, 
       class: 'pure-button pure-button-primary'
  end

  # Translate Collection
  def tc(prefix, collection)
    collection.map do |item|
      [I18n.t("#{prefix}.#{item}"), item]
    end
  end
end
