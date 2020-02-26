class CreateFriendUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :friend_users do |t|
      t.references :user, foreign_key: true
      t.references :friend, foreign_key: true
      t.timestamps
    end
  end
end
