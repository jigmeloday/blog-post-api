class CreateFollow < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.belongs_to :followed_user
      t.belongs_to :user
      t.timestamps
    end
  end
end
