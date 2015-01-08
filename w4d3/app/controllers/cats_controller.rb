class CatsController < ApplicationController
  before_action :verify_authorized, only: [:edit, :update, :destroy]

  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def new
    @cat = Cat.new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update
    @cat = Cat.find(params[:id])

    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  def destroy
    @cat = Cat.find(params[:id])
    Cat.destroy(@cat)
    redirect_to cats_url
  end

  private

  def cat_params
    params.require(:cat).permit(:birth_date, :color, :sex, :description, :name)
  end

  def verify_authorized
    cat = Cat.find(params[:id])
    redirect_to cat_url(cat) if current_user.id != cat.owner.id
  end
end
