class RemoveSubtitles < ActiveRecord::Migration
  def change
    remove_column :nodes, :subtitle
  end
end
