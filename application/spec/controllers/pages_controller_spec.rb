require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #home' do
    it 'returns a successful response' do
      get :home
      expect(response).to be_successful
      expect(response).to render_template(:home)
    end
  end

  describe 'GET #privacy' do
    it 'returns a successful response' do
      get :privacy
      expect(response).to be_successful
      expect(response).to render_template(:privacy)
    end
  end

  describe 'GET #privacy' do
    it 'returns a successful response' do
      get :privacy
      expect(response).to be_successful
      expect(response).to render_template(:privacy)
    end
  end

  describe 'GET #privacy' do
    it 'returns a successful response' do
      get :privacy
      expect(response).to be_successful
      expect(response).to render_template(:privacy)
    end
  end

  describe 'GET #find' do
    let!(:post1) { create(:post, title: 'Example Title') }
    let!(:post2) { create(:post, title: 'Another Title') }

    before do
      Post.__elasticsearch__.refresh_index! # Ensure the index is refreshed before each test
      allow(Post).to receive(:search).and_call_original
    end

    context 'when title is present' do
      it 'returns posts matching the title' do
        get :find, params: { title: 'Example' }
        expect(response).to be_successful
        expect(assigns(:posts).records.to_a).to include(post1)
        expect(assigns(:posts).records.to_a).not_to include(post2)
      end
    end

    context 'when title is not present' do
      it 'returns no posts' do
        get :find, params: { title: '' }
        expect(response).to be_successful
        expect(assigns(:posts).records.to_a).to be_empty
      end
    end

    context 'when Elasticsearch query fails' do
      before do
        allow(Post).to receive(:search).and_raise(StandardError.new("Elasticsearch query error"))
      end

      it 'logs an error and returns no posts' do
        expect(Rails.logger).to receive(:error).with(/Elasticsearch query error/)
        get :find, params: { title: 'Example' }
        expect(response).to be_successful
        expect(assigns(:posts)).to be_empty
      end
    end
  end
end
