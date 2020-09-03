class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :set_tag, only: [:index, :new, :create, :show, :edit, :update, :search, :tag]
  
  def index
    @posts = Post.includes(:user).order("created_at DESC")
  end

  def new
    @post = Post.new
    @post.post_tags.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      redirect_to root_path, notice: '記事を投稿しました。'
    else
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path, notice: '記事を削除しました。'
  end

  def show
    @comments = @post.comments.includes(:user)
    @comment = @post.comments.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to root_path, notice: '記事を更新しました'
    else
      render :edit
    end
  end

  def search
    @posts = Post.search(params[:keyword]).includes(:user).order("created_at DESC")
  end

  def tag
    @tag = Tag.find_by(name: params[:name])
    @posts = Post.where('hashtag LIKE(?)', "%#{@tag.name}%").includes(:user).order("created_at DESC")
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :type,:hashtag, hashtag_ids: []).merge(user_id: current_user.id)
  end
  
  def set_post
    @post = Post.find(params[:id])
  end

  def set_tag
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
  end
end
