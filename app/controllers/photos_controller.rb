class PhotosController < ApplicationController
  def index
    @photos = current_space.photos.order('created_at DESC')
  end
end
