class AddEngagedPeopleNamesToMicroPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :micro_posts, :engaged_people_names, :text
  end
end
