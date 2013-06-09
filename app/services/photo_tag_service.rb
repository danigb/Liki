class PhotoTagService
  attr_reader :space, :user

  def initialize(space, user)
    @space = space
    @user = user
  end

  def create(form)
    begin
      node = space.nodes.find(form.node_title.parameterize)
      tag = form.photo.tag(node)
      NotifierWorker.perform_async(
        :create, 'PhotoTag', user.id, tag.id) if tag
      return true
    rescue ActiveRecord::RecordNotFound
      return false
    end
  end

  def destroy(photo_tag)
    photo_tag.destroy
  end
end
