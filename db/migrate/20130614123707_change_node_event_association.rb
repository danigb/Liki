class ChangeNodeEventAssociation < ActiveRecord::Migration
  def change
    add_column :events, :node_id, :integer
    add_index :events, :node_id

    Node.where("event_id is not null").each do |node|
      event = Event.find node.event_id
      event.update_column(:node_id, node.id)
    end
    remove_column :nodes, :event_id
  end
end
