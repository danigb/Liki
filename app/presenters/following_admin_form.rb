class FollowingAdminForm < BasicForm
  model :following_admin, on: :node
  
  property :title, on: :node
  property :add_follower_user_name, on: :action
end

