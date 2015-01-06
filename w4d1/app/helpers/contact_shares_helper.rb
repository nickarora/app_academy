module ContactSharesHelper

  def contact_share_params
    params.require(:contact_share).permit(:contact_id, :user_id)
  end


end
