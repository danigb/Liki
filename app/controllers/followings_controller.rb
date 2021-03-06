class FollowingsController < ApplicationController
  before_filter :require_user, except: [:index]

  def index
    @followings = node.followings
  end

  def create
    model = Node.find(params[:n]) if params[:n].present?
    model = Space.find(params[:s]) if params[:s].present?
    Following.follow(model, current_user)
    redirect_to model, notice: "Ahora sigues '#{model.label}'"
  end

  def destroy
    following = Following.find(params[:id])
    followed = following.followed
    following.destroy
    redirect_to followed, notice: "Has dejado de seguir '#{followed.label}'"
  end

  protected
  def node
    @node ||= Node.find(params[:node_id])
  end
end
