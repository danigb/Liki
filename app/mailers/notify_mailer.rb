class NotifyMailer < ActionMailer::Base
  default from: 'lapelicanacrianza@gmail.com'

  def group_follower_node_created(recipient, node)
    @recipient = recipient
    @node = node
    @group = node.group
    mail to: @recipient.email, subject: "Han añadido una página a #{@group.name}"
  end

  def group_follower_node_updated(recipient, node)
    @recipient = recipient
    @node = node
    @group = node.group
    mail to: @recipient.email, subject: "Han modificado una página en #{@group.name}"
  end

  def children_node_created(recipient, node)
    @recipient = recipient
    @node = node
    @parent = node.parent
    mail to: @recipient.email, subject: "Han añadido una página hija a #{@parent.label}"
  end
end
