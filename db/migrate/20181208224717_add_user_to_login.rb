class AddUserToLogin < ActiveRecord::Migration[5.2]
  def change
    add_reference :logins, :user, foreign_key: true
  end
end
