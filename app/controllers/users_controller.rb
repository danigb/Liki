class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
    member = current_group.member(@user)
    redirect_to member.node
  end
end
