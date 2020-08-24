class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    # binding.pry
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.delete
    redirect_back(fallback_location: root_path)
    # notice: 'いいねを解除しました。'
  end
end
