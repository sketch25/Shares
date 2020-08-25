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
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
    # @like = Like.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :icon, :email, :profile)
  end
end
