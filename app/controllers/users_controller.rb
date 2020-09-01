class UsersController < ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:user).order("created_at DESC")
    @comments = @user.comments.includes(:user)
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
    @likes_count = User.likes_count(@posts)
    @bads_count = User.bads_count(@posts)
    @comgoods_count = User.comgoods_count(@comments)
    @combads_count = User.combads_count(@comments)
    @evaluate = User.evaluate_user(@likes_count, @bads_count, @comgoods_count, @combads_count)
  end
  
  def show_following
    @user = User.find(params[:user_id])
    @user_following = @user.followings
    @posts = @user.posts.includes(:user).order("created_at DESC")
    @comments = @user.comments.includes(:user)
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
    @likes_count = User.likes_count(@posts)
    @bads_count = User.bads_count(@posts)
    @comgoods_count = User.comgoods_count(@comments)
    @combads_count = User.combads_count(@comments)
    @evaluate = User.evaluate_user(@likes_count, @bads_count, @comgoods_count, @combads_count)
  end

  def show_follower
    @user = User.find(params[:user_id])
    @user_follower = @user.followers
    @posts = @user.posts.includes(:user).order("created_at DESC")
    @comments = @user.comments.includes(:user)
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
    @likes_count = User.likes_count(@posts)
    @bads_count = User.bads_count(@posts)
    @comgoods_count = User.comgoods_count(@comments)
    @combads_count = User.combads_count(@comments)
    @evaluate = User.evaluate_user(@likes_count, @bads_count, @comgoods_count, @combads_count)
  end

  def show_article
    @user = User.find(params[:user_id])
    @user_follower = @user.followers
    @post = @user.posts.includes(:user)
    @posts = @user.posts.where(type: 0).includes(:user).order("created_at DESC")
    @comments = @user.comments.includes(:user)
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
    @likes_count = User.likes_count(@post)
    @bads_count = User.bads_count(@post)
    @comgoods_count = User.comgoods_count(@comments)
    @combads_count = User.combads_count(@comments)
    @evaluate = User.evaluate_user(@likes_count, @bads_count, @comgoods_count, @combads_count)
  end

  def show_question
    @user = User.find(params[:user_id])
    @user_follower = @user.followers
    @post = @user.posts.includes(:user)
    @posts = @user.posts.where(type: 1).includes(:user).order("created_at DESC")
    @comments = @user.comments.includes(:user)
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
    @likes_count = User.likes_count(@post)
    @bads_count = User.bads_count(@post)
    @comgoods_count = User.comgoods_count(@comments)
    @combads_count = User.combads_count(@comments)
    @evaluate = User.evaluate_user(@likes_count, @bads_count, @comgoods_count, @combads_count)
  end

  def show_comment
    @user = User.find(params[:user_id])
    @user_follower = @user.followers
    @posts = @user.posts.includes(:user).order("created_at DESC")
    @comments = @user.comments.includes(:user)
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
    @likes_count = User.likes_count(@posts)
    @bads_count = User.bads_count(@posts)
    @comgoods_count = User.comgoods_count(@comments)
    @combads_count = User.combads_count(@comments)
    @evaluate = User.evaluate_user(@likes_count, @bads_count, @comgoods_count, @combads_count)
  end

  def show_like
    @user = User.find(params[:user_id])
    @user_follower = @user.followers
    @posts = @user.liked_posts.includes(:user).order("created_at DESC")
    @post = @user.posts.includes(:user)
    @comments = @user.comgood_comments.includes(:user).order("created_at DESC")
    @comment = @user.comments.includes(:user)
    @posts = User.posts_comments_sort(@posts, @comments)
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
    @likes_count = User.likes_count(@post)
    @bads_count = User.bads_count(@post)
    @comgoods_count = User.comgoods_count(@comment)
    @combads_count = User.combads_count(@comment)
    @evaluate = User.evaluate_user(@likes_count, @bads_count, @comgoods_count, @combads_count)
  end


  private

  def user_params
    params.require(:user).permit(:name, :nickname, :icon, :email, :profile)
  end
end
