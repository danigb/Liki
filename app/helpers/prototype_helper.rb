module PrototypeHelper
  def has_photos?(node)
    node.photos.count > 0 || node.proto.photos?
  end

  def has_tasks?(node)
    false && node.proto.tasks?
  end

  def has_document?(node)
    node.document.present? || node.proto.document?
  end

  def has_address?(node)
    node.map_address.present? || node.proto.map_marker?
  end

  def has_event?(node)
    node.event.present?
  end
end
