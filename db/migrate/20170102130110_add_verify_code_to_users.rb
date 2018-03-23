class AddVerifyCodeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :verify_code, :string
  end
end
