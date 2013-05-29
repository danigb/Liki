class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :user, index: true
      t.belongs_to :space, index: true
      t.string :action, limit: 16
      t.belongs_to :trackable
      t.string :trackable_type
      t.timestamps
    end
    add_index :activities, [:trackable_id, :trackable_type]

    Node.find_each do |node|
      a = Activity.track('create', node, node.user)
      a.update_columns(created_at: node.created_at,
                       updated_at: node.created_at)
    end
  end
end
