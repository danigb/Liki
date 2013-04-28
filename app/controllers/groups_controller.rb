class GroupsController < ApplicationController
  def show
    redirect_to current_group.node
  end
end
