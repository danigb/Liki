class PhotoTagsController < ApplicationController
  def create
    form = TagPhotoFormPresenter.build(params)
    photo = Photo.find form.photo_id
    begin
      node = current_space.nodes.find(form.node_title.parameterize)
      photo.tag(node)
      flash.notice = 'Foto añadida. ¡Bien!'
    rescue ActiveRecord::RecordNotFound
      flash.alert = "No se ha añadido porque la página #{form.node_title} no existe."
    end
    redirect_to photo
  end

  def destroy
    photo_tag = PhotoTag.find params[:id]
    photo_tag.destroy
    redirect_to photo_tag.photo
  end
end
