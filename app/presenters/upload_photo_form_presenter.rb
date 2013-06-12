class UploadPhotoFormPresenter < FormPresenter
  attr_accessor :node_id
  attr_accessor :image

  def node
    @node = Node.where(id: node_id).first
  end
end
