class AddIsOpenToSpace < ActiveRecord::Migration
  def change
    add_column :spaces, :is_open, :boolean, default: false
  end
end
