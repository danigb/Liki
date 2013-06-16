module PrototypeHelper
  def has_url?(node)
    node.url? || node.proto.url?
  end

  def has_body?(node)
    node.body? || node.proto.body?
  end

  def has_contact?(node)
    node.proto.contact?
  end

  def has_comments?(node)
    node.comments.count > 0 || node.proto.comments?
  end

  def has_photos?(node)
    node.photos.count > 0 || node.proto.photos?
  end

  def has_tasks?(node)
    false && node.proto.tasks?
  end

  def has_document?(node)
    node.document.present? || node.proto.document?
  end

  def has_event?(node)
    node.event.present? || node.proto.event?
  end
end
