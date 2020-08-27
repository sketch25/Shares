class BadsController < ApplicationController
  def create
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    if @like.present?
      @like.delete
    end
    @bad = current_user.bads.create(post_id: params[:post_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @bad = Bad.find_by(post_id: params[:post_id], user_id: current_user.id)
    @bad.delete
    redirect_back(fallback_location: root_path)
  end
end
