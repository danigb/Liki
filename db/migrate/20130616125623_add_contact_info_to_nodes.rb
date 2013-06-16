class AddContactInfoToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :url, :string
    add_column :nodes, :telephone, :string
    add_column :nodes, :email, :string
    add_column :nodes, :move_commonts, :string
    add_column :nodes, :begin_date, :date
  end
end
