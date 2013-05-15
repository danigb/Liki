class ExplorerController < ApplicationController
  before_filter :require_user
  respond_to :html

  def map
    all = current_space.nodes.where('title IS NOT NULL')
    mentions = current_space.mentions
    ms = mentions.map do |mention|
      if mention.from.title.present? && mention.to.title.present?
      [mention.from.title, mention.to.title, {color: '#EDC951'}] 
      end
    end.compact()
    titles = all.map &:title
    all.each do |node|
      ms << [node.parent.title, node.title, {color: '#CC333F'}] if node.parent
    end
    @data = Jbuilder.encode do |json|
      json.nodes titles
      json.edges ms
    end
  end

end