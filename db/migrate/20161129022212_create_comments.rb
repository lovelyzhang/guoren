class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :micro_post_id
      t.datetime :comment_time

      t.timestamps
    end
  end
end
