class NotifyMailer < ActionMailer::Base
  default from: 'lapelicanacrianza@gmail.com'

  def space_follower_node_created(recipient, node)
    @recipient = recipient
    @node = node
    @space = node.space
    mail to: @recipient.email, subject: "Han añadido una página a #{@space.name}"
  end

  def space_follower_node_updated(recipient, node)
    @recipient = recipient
    @node = node
    @space = node.space
    mail to: @recipient.email, subject: "Han modificado una página en #{@space.name}"
  end

  def children_node_created(recipient, node)
    @recipient = recipient
    @node = node
    @parent = node.parent
    mail to: @recipient.email, subject: "Han añadido una página hija a #{@parent.label}"
  end
end
