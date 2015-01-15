class SubsController < ApplicationController

  before_action :verify_moderator, only: [:edit, :update]
  before_action :verify_logged_in

  def index
    @subs = Sub.all

    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts

    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def edit
    @sub = Sub.find(params[:id])

    render :edit
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      flash.now[:notice] = "Success!"

      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages

      render :new
    end
  end

  def update
    @sub = Sub.find(params[:id])
    @sub.moderator_id = current_user.id

    if @sub.update(sub_params)
      flash.now[:notice] = "Success!"

      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages

      render :edit
    end
  end

  private

    def sub_params
      params.require(:sub).permit(:title, :description, :moderator_id)
    end

    def verify_moderator
      sub = Sub.find(params[:id])
      redirect_to sub_url(sub) unless current_user.id == sub.moderator_id
    end

    def verify_logged_in
      redirect_to new_session_url unless current_user
    end

end
