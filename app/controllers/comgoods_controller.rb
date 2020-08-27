class ComgoodsController < ApplicationController
  def create
    @combad = Combad.find_by(comment_id: params[:comment_id], user_id: current_user.id)
    if @combad.present?
      @combad.destroy
    end
    @comgood = current_user.comgoods.create(comment_id: params[:comment_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comgood = Comgood.find_by(comment_id: params[:comment_id], user_id: current_user.id)
    @comgood.destroy
    redirect_back(fallback_location: root_path)
  end
end
