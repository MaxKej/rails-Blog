require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:post_instance) { FactoryBot.create(:post) }
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:comment) { FactoryBot.create(:comment, post: post_instance, user: user) }

  before do
    sign_in user # Ensure a user is signed in for non-admin actions
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new comment and redirects to the post' do
        post :create, params: { post_id: post_instance.id, comment: { content: 'Great post!' } }
        expect(response).to redirect_to(post_instance)
        expect(flash[:notice]).to eq('Komentarz został pomyślnie utworzony.')
        expect(post_instance.comments.last.content).to eq('Great post!')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new comment and redirects to the post with an alert' do
        post :create, params: { post_id: post_instance.id, comment: { content: '' } }
        expect(response).to redirect_to(post_instance)
        expect(flash[:alert]).to eq('Nie udało się utworzyć komentarza.')
      end
    end
  end

  describe 'PATCH #update' do
    before do
      sign_in admin # Only admin can update
    end

    context 'with valid attributes' do
      it 'updates the comment and redirects to the post' do
        patch :update, params: { post_id: post_instance.id, id: comment.id, comment: { content: 'Updated content' } }
        expect(response).to redirect_to(post_instance)
        expect(flash[:notice]).to eq('Komentarz został pomyślnie zaktualizowany.')
        expect(comment.reload.content).to eq('Updated content')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the comment and re-renders the edit form' do
        patch :update, params: { post_id: post_instance.id, id: comment.id, comment: { content: '' } }
        expect(response).to render_template(:edit)
        expect(comment.reload.content).not_to eq('')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      sign_in admin # Only admin can delete
    end

    it 'destroys the comment and redirects to the post' do
      delete :destroy, params: { post_id: post_instance.id, id: comment.id }
      expect(response).to redirect_to(post_instance)
      expect(flash[:notice]).to eq('Komentarz został pomyślnie usunięty.')
      expect(Comment.exists?(comment.id)).to be_falsey
    end
  end
end
