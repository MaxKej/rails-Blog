class AddUserToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :user, null: true, foreign_key: true
    remove_column :comments, :timestamp
    remove_column :comments, :comment_author
  end
end
