class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.belongs_to :creator, class_name: 'User', null: false
      t.float :lon
      t.float :lat
      t.integer :radius
      t.string :tags, array: true, default: [], null: false
      t.datetime :start_at
      t.datetime :end_at
      t.integer :duration
      t.integer :limit
      t.boolean :is_deleted, default: false, null: false
      t.timestamps
    end
  end
end
