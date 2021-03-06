class CombadsController < ApplicationController
  def create
    @comgood = Comgood.find_by(comment_id: params[:comment_id], user_id: current_user.id)
    if @comgood.present?
      @comgood.destroy
    end
    @combad = current_user.combad.create(comment_id: params[:comment_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @combad = Combad.find_by(comment_id: params[:comment_id], user_id: current_user.id)
    @combad.destroy
    redirect_back(fallback_location: root_path)
  end
end