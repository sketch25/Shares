require 'rails_helper'

describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:tag) { create(:tag) }

  describe 'GET #index' do
    context 'log in' do
      before do
        login user
        posts = create_list(:post, 3) 
        get :index
        expect(assigns(:posts)).to match(posts.sort{ |a, b| b.created_at <=> a.created_at } )
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

  describe 'GET #new' do
    context 'log in' do
      before do
        login user
      end
      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    context 'not log in' do
      it 'redirects to new_user_session_path' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    let(:params) { { user_id: user.id, hashtag: "#" + tag.name, post: attributes_for(:post) } }
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

  describe 'GET #edit' do
    context 'log in' do
      before do
        login user
      end
      it "assigns the requested post to @post" do
        edit_post = create(:post)
        get :edit, params: { id: edit_post }
        expect(assigns(:post)).to eq edit_post 
      end
  
      it "renders the :edit template" do
        edit_post = create(:post)
        get :edit, params: { id: edit_post }
        expect(response).to render_template :edit
      end
    end

    context 'not log in' do
      it 'redirects to new_user_session_path' do
        edit_post = create(:post)
        get :edit, params: { id: edit_post }
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
        destroy_post = create(:post)
        delete :destroy, params: { id: destroy_post }
        expect(response).to redirect_to(root_path)
      end

      it 'count down post' do
        destroy_post = create(:post)
        expect{delete :destroy, params: { id: destroy_post }}.to change(Post, :count).by(-1)
      end
    end

    context 'not log in' do
      it 'redirects to new_user_session_path' do
        destroy_post = create(:post)
        delete :destroy, params: { id: destroy_post }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #show' do
    it "renders the :show template" do
      show_post = create(:post)
      get :show, params: { id: show_post }
      expect(response).to render_template :show
    end
  end

  describe 'PATCH #update' do
    context 'log in' do
      before do
        login user
      end
      it "renders the :update template" do
        update_post = create(:post)
        patch :update, params: { id: update_post, user_id: user.id, hashtag: "#" + tag.name, post: attributes_for(:post) }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'not log in' do
      it 'redirects to new_user_session_path' do
        update_post = create(:post)
        patch :update, params: { id: update_post }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #search" do
    it "renders the :search template" do
      get :search
      expect(response).to render_template :search
    end
  end


end