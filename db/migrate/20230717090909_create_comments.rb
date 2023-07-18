class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, null: false
      t.string :body, null: false
      t.integer :like_count, null: false, default: 0
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
