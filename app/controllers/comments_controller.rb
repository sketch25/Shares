class CommentsController < ApplicationController
  before_action :set_tag, only: [:new, :create, :edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    comment = Comment.create(comment_params)
    if comment.save
      redirect_to "/posts/#{comment.post_id}", notice: 'コメントを投稿しました。'
    else
      redirect_to "/posts/#{comment.post_id}", alert: 'コメントの投稿に失敗しました。'
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find_by(post_id: params[:post_id], id: params[:id])
  end

  def update
    @comment = Comment.find_by(post_id: params[:post_id], id: params[:id])
    if @comment.update(comment_params)
      redirect_to "/posts/#{@comment.post_id}", notice: 'コメントを編集しました。'
    else
      redirect_to "/posts/#{@comment.post_id}/comments/#{@comment.id}/edit", alert: 'コメントの編集に失敗しました。'
    end
  end

  def destroy
    comment = Comment.find_by(post_id: params[:post_id], id: params[:id])
    comment.destroy
    redirect_to "/posts/#{comment.post_id}", notice: '記事を削除しました。'
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, post_id: params[:post_id])
  end
  
  def set_tag
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
  end

end
