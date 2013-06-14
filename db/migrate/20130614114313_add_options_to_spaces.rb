class AddOptionsToSpaces < ActiveRecord::Migration
  def change
    [:wiki, :calendar, :photos, :map].each do |service|
      add_column :spaces, "has_#{service}", :boolean, default: false
    end
  end
end
