class AddUserIdToMicroPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :micro_posts, :user_id, :integer
  end
end
