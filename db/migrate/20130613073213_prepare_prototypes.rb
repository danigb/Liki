class PreparePrototypes < ActiveRecord::Migration
  def change
    add_column :prototypes, :photos, :boolean, default: false
    add_column :prototypes, :tasks, :boolean, default: false
    add_column :prototypes, :comments, :boolean, default: false
    add_column :prototypes, :document, :boolean, default: false
    add_column :prototypes, :show_map, :boolean, default: false
    add_column :prototypes, :map_marker, :boolean, default: false
    add_column :prototypes, :event, :boolean, default: false
    add_column :prototypes, :children_id, :integer
    remove_column :prototypes, :children_names

    ActiveRecord::Base.record_timestamps = false
    Prototype.destroy_all

    Space.find_each do |space|
      space.prototypes.create(name: 'página')
    end

    Node.where("children_name <> ''").each do |node|
      proto = find_or_create_proto(node)
      node.children.each do |child|
        child.prototype = proto
        child.save
      end
    end
  end

  protected
  def find_or_create_proto(node)
    name = node.children_name
    space = node.space
    proto = space.prototypes.where(name: name).first
    if proto.blank?
      proto = Prototype.create(space: space, name: name)
    end
    proto
  end
end
