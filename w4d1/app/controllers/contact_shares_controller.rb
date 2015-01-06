class ContactSharesController < ApplicationController

  include ContactSharesHelper

  def create
    @contact_share = ContactShare.new(contact_share_params)
    if @contact_share.save
      render json: @contact_share
    else
      render(json: @contact_share.errors.full_messages,
             status: :unprocessable_entity)
    end
  end

  def destroy
    @contact_share = ContactShare.find(params[:id])
    if ContactShare.destroy(@contact_share)
      render json: @contact_share
    else
      render(json: @contact_share.errors.full_messages,
            status: :unprocessable_entity)
    end
  end

end
