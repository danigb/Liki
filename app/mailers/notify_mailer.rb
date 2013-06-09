class NotifyMailer < ActionMailer::Base
  default from: 'hola@liki.es'

  def space_follower_node_created(recipient, node)
    subject = "Han añadido una página"
    send_notification subject, node, recipient
  end

  def space_follower_node_updated(recipient, node)
    subject = "Han modificado una página"
    send_notification subject, node, recipient
  end

  def children_node_created(recipient, node)
    if node.parent
      subject = "Han añadido una página a #{node.parent.title}"
      send_notification subject, node, recipient
    end
  end

  def photo_tag_created(recipient, tag)
    node = tag.node
    subject = "Han añadido una foto a #{node.title}"
    send_notification subject, node, recipient
  end


  protected
  def send_notification(subject, node, recipient)
    @recipient = recipient
    @node = node
    @space = node.space
    UserMailer.default_url_options[:host] = @space.host

    mail to: @recipient.email, from: @space.email,
      subject: "[#{@space.name}] #{subject}"
  end
end
