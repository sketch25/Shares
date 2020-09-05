require 'rails_helper'

describe PostsController do
  let(:user) { create(:user) }

  describe '#index' do

    context 'log in' do
      before do
        login user
        get :index
      end

      it 'renders index' do
        expect(response).to render_template :index
      end
    end

    context 'not log in' do
      before do
        get :index
      end

      it 'renders index' do
        expect(response).to render_template :index
      end
    end
  end

  describe '#create' do
    let(:params) { { user_id: user.id, post: attributes_for(:post) } }

    context 'log in' do
        before do
          login user
        end
  
        context 'can save' do
          subject {
              post :create,
              params: params
          }

          it 'count up post' do
            expect{ subject }.to change(Post, :count).by(1)
          end

          it 'redirects to root_path' do
            subject
            expect(response).to redirect_to(root_path)
          end
        end
  
        context 'can not save' do
          let(:invalid_params) { { user_id: user.id, post: attributes_for(:post, title: nil, content: nil) } }

          subject {
              post :create,
              params: invalid_params
          }
          it 'does not count up' do
            expect{ subject }.not_to change(Post, :count)
          end

          it 'renders new' do
            subject
            expect(response).to render_template :new
          end
        end
      end
  
    context 'not log in' do
      
      it 'redirects to new_user_session_path' do
        get :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end