require 'rails_helper'

describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:comment_post) { create(:post) }

  describe 'POST #create' do
    let(:params) { { user_id: user.id, post_id: comment_post.id, comment: attributes_for(:comment) } }
    
    context 'log in' do
        before do
          login user
        end
  
        context 'can save' do
          subject {
            post :create,
            params: params
          }

          it 'count up comment' do
            expect{ subject }.to change(Comment, :count).by(1)
          end

          it 'redirects to post_show' do
            subject
            expect(response).to redirect_to("/posts/#{comment_post.id}")
          end
        end
  
        context 'can not save' do
          let(:invalid_params) { { user_id: user.id, post_id: comment_post.id, comment: attributes_for(:comment,  content: nil) } }

          subject {
              post :create,
              params: invalid_params
          }
          it 'does not count up' do
            expect{ subject }.not_to change(Comment, :count)
          end

          it 'redirects to post_show' do
            subject
            expect(response).to redirect_to("/posts/#{comment_post.id}")
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

  describe 'GET #edit' do
    context 'log in' do
      before do
        login user
      end
      it "assigns the requested comment to @comment" do
        comment = create(:comment, user_id: user.id, post_id: comment_post.id)
        get :edit, params: { id: comment, user_id: user.id, post_id: comment_post.id }
        expect(assigns(:comment)).to eq comment 
      end
  
      it "renders the :edit template" do
        comment = create(:comment, user_id: user.id, post_id: comment_post.id)
        get :edit, params: { id: comment, user_id: user.id, post_id: comment_post.id }
        expect(response).to render_template :edit
      end
    end

    context 'not log in' do
      it 'redirects to new_user_session_path' do
        comment = create(:comment, user_id: user.id, post_id: comment_post.id)
        get :edit, params: { id: comment, user_id: user.id, post_id: comment_post.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'log in' do
      before do
        login user
      end
      it "renders the :destroy template" do
        comment = create(:comment, user_id: user.id, post_id: comment_post.id)
        delete :destroy, params: { id: comment, user_id: user.id, post_id: comment_post.id }
        expect(response).to redirect_to(("/posts/#{comment_post.id}"))
      end

      it 'count down comment' do
        comment = create(:comment, user_id: user.id, post_id: comment_post.id)
        expect{delete :destroy, params: { id: comment, user_id: user.id, post_id: comment_post.id }}.to change(Comment, :count).by(-1)
      end
    end

    context 'not log in' do
      it 'redirects to new_user_session_path' do
        comment = create(:comment, user_id: user.id, post_id: comment_post.id)
        delete :destroy, params: { id: comment, user_id: user.id, post_id: comment_post.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end