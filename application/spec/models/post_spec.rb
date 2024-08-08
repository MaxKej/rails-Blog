require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  describe 'Elasticsearch indexing' do
    it 'indexes title and content in lowercase' do
      user = create(:user)
      post = create(:post, user: user, title: 'Sample Title', content: 'Sample Content')

      expected_indexed_json = {
        'title' => 'sample title',
        'content' => 'sample content',
        'user_id' => user.id
      }

      expect(post.as_indexed_json).to eq(expected_indexed_json)
    end
  end

  describe 'role management' do
    it 'assigns the admin role to a user' do
      admin = create(:user, :admin)
      expect(admin.has_role?(:admin)).to be true
    end

    it 'assigns the normal role to a user' do
      normal_user = create(:user, :normal)
      expect(normal_user.has_role?(:normal)).to be true
    end
  end
end
