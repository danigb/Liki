class CleanFollowings < ActiveRecord::Migration
  def change
    Following.find_each do |f|
      f.destroy if f.followed.blank?
    end
  end
end
