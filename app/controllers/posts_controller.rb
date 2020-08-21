class PostsController < ApplicationController

  def index
    @posts = Post.includes(:user).order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      redirect_to root_path, notice: '記事を投稿しました。'
    else
      render :new
    end
    # redirect_to action: 'index'
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path, notice: '記事を削除しました。'
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path, notice: '記事を更新しました'
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content).merge(user_id: current_user.id)
  end


end
