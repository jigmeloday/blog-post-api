class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.integer :shared_count, null: false, default: 0
      t.integer :like_count, null: false, default: 0
      t.integer :comment_count, null: false, default: 0
      t.belongs_to :user
      t.timestamps
    end
  end
end
