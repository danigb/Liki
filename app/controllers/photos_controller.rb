class PhotosController < ApplicationController
  respond_to :html
  before_filter :require_user, except: [:index, :show]

  def index
    redirect_to current_space.photos_node
  end

  def show
    respond_with photo
  end

  protected
  def photo
    @photo ||= Photo.find params[:id]
  end
end
