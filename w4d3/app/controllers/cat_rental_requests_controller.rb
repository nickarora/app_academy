class CatRentalRequestsController < ApplicationController

  before_action :verify_authorized, only: [:approve, :deny, :destroy]
  before_action :verify_logged_in, only: [:new, :create]

  def new
    @request = CatRentalRequest.new
    @request.cat_id = params[:cat_id]
    @cats = Cat.all
  end

  def create
    @cats = Cat.all #to show the cats in render :new

    @request = CatRentalRequest.new(req_params)
    @request.user_id = current_user.id
    
    if @request.save
      redirect_to cat_url(req_params[:cat_id])
    else
      render :new
    end
  end

  def approve
    @request = CatRentalRequest.find(params[:id])
    @request.approve!
    redirect_to cat_url(@request.cat_id)
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    @request.deny!
    redirect_to cat_url(@request.cat_id)
  end

  def destroy
    @request = CatRentalRequest.find(params[:id])
    CatRentalRequest.destroy(@request)
    redirect_to cat_url(@request.cat_id)
  end

  private
    def req_params
      params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
    end

    def verify_logged_in
      redirect_to login_url unless current_user
    end

    def verify_authorized
      request = CatRentalRequest.find(params[:id])
      cat = Cat.find(request.cat_id)
      redirect_to cat_url(cat) if current_user.id != cat.owner.id
    end

end
