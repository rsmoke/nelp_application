class CreateLogins < ActiveRecord::Migration[5.2]
  def change
    create_table :logins do |t|
      t.string :name, null: false
      t.string :google_id, null: false
      t.string :email_address, null: false

      t.timestamps
    end
  end
end
