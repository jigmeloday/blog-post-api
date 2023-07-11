class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :likable, polymorphic: true, null: false # this will g both likable and likeable_type
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
