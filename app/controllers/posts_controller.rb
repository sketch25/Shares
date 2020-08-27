class PostsController < ApplicationController

  def index
    @posts = Post.includes(:user).order("created_at DESC")
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
  end

  def new
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
    @post = Post.new
    @post.post_tags.new
  end

  def create
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
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
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
    @comment = @post.comments.new
  end

  def edit
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
    @post = Post.find(params[:id])
  end

  def update
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path, notice: '記事を更新しました'
    else
      render :edit
    end
  end

  def search
    # binding.pry
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
    @posts = Post.search(params[:keyword]).includes(:user).order("created_at DESC")
  end

  def tag
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
    @tag = Tag.find_by(name: params[:name])
    tag =  @tag.name
    @posts = Post.where('hashtag LIKE(?)', "%#{tag}%").includes(:user).order("created_at DESC")
    # binding.pry
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :type,:hashtag, hashtag_ids: []).merge(user_id: current_user.id)
  end


end
