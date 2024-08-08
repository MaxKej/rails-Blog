require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user).optional }
  end

  describe 'pagination' do
    it 'paginates comments' do
      post = create(:post) # Ensure you have a post to associate with comments
      user = create(:user) # Ensure user creation does not conflict

      # Create more comments than the pagination limit
      create_list(:comment, 15, post: post, user: user)

      paginated_comments = Comment.page(1).per(10)

      expect(paginated_comments.size).to eq(10)
      expect(paginated_comments.first).to be_a(Comment)
    end
  end

end