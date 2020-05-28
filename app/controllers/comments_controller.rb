class CommentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :set_post,  :set_comment, :only =>[:edit, :update, :destroy]#except: [:create]

  def create
    byebug
    @post=Post.find(params[:comment][:post_id])
    @comment= @post.comments.create(comment_params)
    if @reply.save #if this returns not nill values, then it is success
      flash.notice = "The reply was created successfully."
      redirect_to @post
    else
      flash.now.alert = @reply.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    @comment.update(comment_params)
    redirect_to @post
  end

  def destroy
    @comment.destroy
    redirect_to @post
  end


  def  set_post
      @post=Post.find(params[:comment][:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end

  def catch_not_found(e)
    Rails.logger.debug("We had a not found exception.")
    flash.alert = e.to_s
    redirect_to orders_path
  end
end
