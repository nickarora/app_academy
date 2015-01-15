# post_comments     POST   /posts/:post_id/comments(.:format)          comments#create
# new_post_comment  GET    /posts/:post_id/comments/new(.:format)      comments#new
# edit_post_comment GET    /posts/:post_id/comments/:id/edit(.:format) comments#edit
# post_comment      GET    /posts/:post_id/comments/:id(.:format)      comments#show
#                   PATCH  /posts/:post_id/comments/:id(.:format)      comments#update
#                   PUT    /posts/:post_id/comments/:id(.:format)      comments#update
#                   DELETE /posts/:post_id/comments/:id(.:format)      comments#destroy

class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      flash.now[:notice] = "Success!"
    else
      flash[:errors] = @comment.errors.full_messages
    end

    redirect_to user_post_url(params[:post_id])
  end

  def update
  end

  def destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :post_id, :author_id, :parent_id)
    end

end
