class RemoveAcademyFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :academy, :string
  end
end
