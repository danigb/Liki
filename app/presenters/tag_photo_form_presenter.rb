class TagPhotoFormPresenter < FormPresenter
  attr_accessor :photo_id
  attr_accessor :node_title

  def photo
    @photo = Photo.find(photo_id)
  end
end
