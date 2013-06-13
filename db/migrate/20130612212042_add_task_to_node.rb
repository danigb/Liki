class AddTaskToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :task_level, :integer, default: 0
    add_column :nodes, :task_priority, :integer, default: 0
  end
end
