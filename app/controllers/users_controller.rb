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
    # binding.pry
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
    # binding.pry
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
    # binding.pry
  end


  private

  def user_params
    params.require(:user).permit(:name, :nickname, :icon, :email, :profile)
  end
end
