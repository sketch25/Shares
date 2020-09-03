class GoodsController < ApplicationController
  def create
    @bad = Bad.find_by(post_id: params[:post_id], user_id: current_user.id)
    if @bad.present?
      @bad.delete
    end
    @good = current_user.goods.create(post_id: params[:post_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @good = Good.find_by(post_id: params[:post_id], user_id: current_user.id)
    @good.delete
    redirect_back(fallback_location: root_path)
  end
end
