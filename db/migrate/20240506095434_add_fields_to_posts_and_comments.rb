class AddFieldsToPostsAndComments < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :author, :string
    add_column :posts, :timestamp, :datetime

    add_column :comments, :comment_author, :string
    add_column :comments, :timestamp, :datetime
  end
end
