class AddSpaceIdToModels < ActiveRecord::Migration
  def change
    Following.where(followed_type: 'Group').delete_all
    add_space_id_column(:accesses, Access, :node)
    add_space_id_column(:taggings, Tagging, :tagged)
    add_space_id_column(:followings, Following, :followed)
  end

  def add_space_id_column(table, klass, parent)
    puts "Migrating #{table}"
    add_column table, :space_id, :integer
    add_index table, :space_id
    puts "Migrating data of #{klass.to_s}"
    klass.find_each do |model|
      if model.send(parent).blank?
        model.destroy
      else
        model.update_attributes(space_id: model.send(parent).space_id)
      end
    end
  end
end
