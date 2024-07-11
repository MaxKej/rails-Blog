class AddUserToPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :user, null: false, foreign_key: true
    remove_column :posts, :timestamp
    remove_column :posts, :author
  end
end
