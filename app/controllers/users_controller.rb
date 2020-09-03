class UsersController < ApplicationController
  before_action :set_tag, except: [:edit, :update]
  before_action :set_page, except: [:edit, :update, :show]

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
    @posts_count =@user.posts.count
    @comments = @user.comments.includes(:user)
    @goods_count = User.goods_count(@posts)
    @bads_count = User.bads_count(@posts)
    @comgoods_count = User.comgoods_count(@comments)
    @combads_count = User.combads_count(@comments)
    @evaluate = User.evaluate_user(@goods_count, @bads_count, @comgoods_count, @combads_count)
  end
  
  def show_following
    @user_following = @user.followings
  end

  def show_follower
    @user_follower = @user.followers
  end

  def show_article
    @posts_article = @user.posts.where(type: 0).includes(:user).order("created_at DESC")
  end

  def show_question
    @posts_question = @user.posts.where(type: 1).includes(:user).order("created_at DESC")
  end

  def show_comment
  end

  def show_good
    @post = @user.good_posts.includes(:user).order("created_at DESC")
    @comment = @user.comgood_comments.includes(:user).order("created_at DESC")
    @goods_list = User.posts_comments_sort(@post, @comment)
  end


  private

  def user_params
    params.require(:user).permit(:name, :nickname, :icon, :email, :profile)
  end

  def set_tag
    @tags = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc')
  end
  
  def set_page
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @comments = @user.comments
    @posts_count =@user.posts.count
    @goods_count = User.goods_count(@posts)
    @bads_count = User.bads_count(@posts)
    @comgoods_count = User.comgoods_count(@comments)
    @combads_count = User.combads_count(@comments)
    @evaluate = User.evaluate_user(@goods_count, @bads_count, @comgoods_count, @combads_count)
  end
  
end
