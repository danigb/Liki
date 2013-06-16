class AddContactsToPrototype < ActiveRecord::Migration
  def change
    rename_column :prototypes, :map_marker, :contact
    rename_column :prototypes, :body, :body_content
    add_column :prototypes, :url, :boolean, default: false
    add_column :prototypes, :body, :boolean, default: true
    add_column :prototypes, :dates, :string, limit: 40

    add_column :nodes, :end_date, :date
  end
end
