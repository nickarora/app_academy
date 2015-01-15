class PostsController < ApplicationController

  before_action :verify_author, only: [:edit, :update]

  def index
    @posts = Post.all

    render :index
  end

  def show
    @post = Post.find(params[:id])

    render :show
  end

  def new
    @post = Post.new
    @checked = []

    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @checked = params[:post][:subs].map(&:to_i) || []

    if @post.save
      flash[:notice] = "Success!"
      @checked.each do |sub|
        Postsub.create!(sub_id: sub, post_id: @post.id)
      end

      redirect_to user_post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages

      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @checked = @post.subs.map { |s| s.id }

    render :edit
  end

  def update
    @post = Post.find(params[:id])
    @checked = params[:post][:subs].map(&:to_i) || []

    if @post.update(post_params)
      flash[:notice] = "Success!"

      Postsub.where(post_id: @post.id).each { |ps| ps.destroy }
      @checked.each do |sub|
        Postsub.create!(sub_id: sub, post_id: @post.id)
      end

      redirect_to user_post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages

      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!

    redirect_to sub_url(params[:sub_id])
  end

  private

    def post_params
      params.require(:post).permit(:title, :url, :content, :author_id, :subs)
    end

    def verify_author
      post = Post.find(params[:id])
      unless current_user.id == post.author_id
        redirect_to sub_post_url(post.sub_id, post.id)
      end
    end

end
