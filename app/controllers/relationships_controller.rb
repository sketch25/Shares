class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:relationship][:follow_id])
    following = current_user.follow(@user)
    if following.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @user = User.find(params[:relationship][:follow_id])
    following = current_user.unfollow(@user)
    if following.destroy
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

end
