class TagPhotoFormPresenter < FormPresenter
  attr_accessor :photo_id
  attr_accessor :node_title

  def self.build(params)
    name = self.name.underscore
    self.new(params[name])
  end
end
