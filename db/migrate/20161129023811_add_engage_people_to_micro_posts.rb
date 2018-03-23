class AddEngagePeopleToMicroPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :micro_posts, :engage_people, :integer
  end
end
