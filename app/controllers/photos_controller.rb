class PhotosController < ApplicationController
  respond_to :html
  before_filter :require_user, except: [:index, :show]

  def index
    redirect_to current_space.photos_node
  end

  def show
    respond_with photo
  end

  def new
    @form = UploadPhotoFormPresenter.new(node_id: params[:n])
    respond_with @form
  end

  def create
    form = UploadPhotoFormPresenter.build(params)
    node = current_space.nodes.find(form.node_id)
    if form.image.present?
      photo = Photo.create!(
        space: current_space, user: current_user,
        image: form.image)
      photo.tag(current_space.photos_node)
      photo.tag(node)
    end
    redirect_to node, notice: 'Imágen subida'
  end

  def destroy
    photo.destroy
    redirect_to photos_path, notice: 'Imágen borrada'
  end


  protected
  def photo
    @photo ||= Photo.find params[:id]
  end
end
