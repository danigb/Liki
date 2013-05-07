class FollowingsController < ApplicationController
  before_filter :require_user

  def create
    model = Node.find(params[:n]) if params[:n].present?
    model = Group.find(params[:g]) if params[:g].present?
    Following.follow(model, current_user)
    redirect_to model, notice: "Ahora sigues '#{model.label}'"
  end

  def destroy
    following = Following.find(params[:id])
    followed = following.followed
    following.destroy
    redirect_to followed, notice: "Has dejado de seguir '#{followed.label}'"
  end
end
