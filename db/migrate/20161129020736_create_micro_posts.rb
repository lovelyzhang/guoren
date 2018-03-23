class CreateMicroPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :micro_posts do |t|
      t.text :content
      t.text :pic
      t.datetime :post_time
      t.integer :type

      t.timestamps
    end
  end
end
