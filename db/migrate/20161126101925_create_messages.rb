class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :send_user
      t.integer :recieve_user
      t.datetime :create_time
      t.boolean :readed
      t.timestamps
    end
  end
end
