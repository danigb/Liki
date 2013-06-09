class PhotosController < ApplicationController
  respond_to :html
  before_filter :require_user, except: [:index, :show]

  def index
    redirect_to current_space.photos_node
  end

  def show
    respond_with photo
  end

  def create
    form = UploadPhotoFormPresenter.build(params)
    node = current_space.nodes.find(form.node_id)
    photo = Photo.create!(
      space: current_space, user: current_user,
      image: form.image)
    photo.tag(current_space.photos_node)
    photo.tag(node)
    redirect_to node, notice: 'Imágen subida'
  end

  protected
  def photo
    @photo ||= Photo.find params[:id]
  end
end
