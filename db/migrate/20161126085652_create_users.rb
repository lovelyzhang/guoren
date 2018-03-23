class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, unique: true
      t.string :email, unique: true
      t.string :picurl
      t.string :profession
      t.string :academy
      t.boolean :sexual

      t.timestamps
    end
  end
end
