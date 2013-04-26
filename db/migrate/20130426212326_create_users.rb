class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, limit: 100, unique: true
      t.string :slug, limit: 100, unique: true
      t.string :email, limit: 200
      t.boolean :admin, default: false
      t.timestamps
    end
    add_index :users, :slug, unique: true
  end
end
