class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.belongs_to :space
      t.belongs_to :node

      t.string :name
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end
