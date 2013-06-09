class PhotoTagsController < ApplicationController
  before_filter :require_user

  def create
    form = TagPhotoFormPresenter.build(params)
    service.create(form) ?
      flash.notice = t('photo_tags.created') :
      flash.alert = t('photo_tags.create_failed', title: form.node_title)
    redirect_to form.photo
  end

  def destroy
    photo_tag = PhotoTag.find params[:id]
    service.destroy(photo_tag)
    redirect_to photo_tag.photo
  end

  protected
  def service
    @service ||= PhotoTagService.new(current_space, current_user)
  end
end
