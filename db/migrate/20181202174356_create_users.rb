class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email_address
      t.string :avatar_url
      t.string :locale
      t.string :hosted_domain

      t.timestamps
    end
  end
end
