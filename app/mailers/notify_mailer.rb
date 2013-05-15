class NotifyMailer < ActionMailer::Base
  default from: 'lapelicanacrianza@gmail.com'

  def space_follower_node_created(recipient, node)
    send_notification "Han añadido una página a #{node.space.name}",
      node, recipient
  end

  def space_follower_node_updated(recipient, node)
    send_notification "Han modificado una página en #{node.space.name}",
      node, recipient
  end

  def children_node_created(recipient, node)
    send_notification "Han modificado una página en #{node.space.name}",
      node, recipient
  end

  protected
  def send_notification(subject, node, recipient)
    @recipient = recipient
    @node = node
    @space = node.space
    mail to: @recipient.email, subject: subject
  end
end
