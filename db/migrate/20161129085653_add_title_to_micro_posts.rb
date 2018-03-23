class AddTitleToMicroPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :micro_posts, :title, :string
  end
end
