class RepliesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :set_comment_and_reply, :only=> [:edit, :update, :destroy]

#afer creating a repply for a comment, it will show Post for that comment/reply

<<<<<<< Updated upstream
  def create
  #  @reply= @comment.replies.create(reply_params)
=======
  def update
    set_reply
    @reply.update(reply_params)

    c=Comment.find(params[:reply][:comment_id])
    post=Post.find(c.post_id)
    redirect_to post_path(post.id)

    #post=Post.find_by(comment_id=params[:id])
  #  redirect_to post_path(post.id)
  end

  def destroy #reply
    set_reply
    @reply.destroy
    #c=Comment.find(params[:reply][:comment_id])
    post=Post.find_by(comment_id=params[:id])
    redirect_to post_path(post.id)
  end

  def create #reply
>>>>>>> Stashed changes
    @reply=Reply.new(reply_params)
    if @reply.save #if this returns not nill values, then it is success
      flash.notice = "The reply was created successfully."
    else
      flash.now.alert = @reply.errors.full_messages.to_sentence
    end
    redirect_to @comment
  end

  def edit
  end

  def update
    @reply.update(reply_params)
    redirect_to @comment
  end

  def destroy
    @reply.destroy
    redirect_to @comment
  end

  private

  def  set_comment_and_reply
      #comment = params [:reply:comment_id]
      cid=params[:reply][:comment_id].to_i
      if (params[:reply][:id])  #test for nil?
        @reply = Reply.find((params[:reply][:id]).to_i)
      end
    @comment=Comment.find(cid)

  end

  def reply_params
    #params.require(:reply).permit(:comment_id, :user_id, :content)
    #params.require(:reply).permit([:reply][:comment_id], [:reply][:user_id], [:reply][:content])
    cid=(params[:reply][:comment_id]).to_i
    params.require(:reply).permit(params[:reply][:comment_id].to_i, params[:reply][:user_id].to_i, params[:reply][:content])
  end

  def catch_not_found(e)
    Rails.logger.debug("We had a not found exception.")
    flash.alert = e.to_s
    redirect_to posts_path
  end

end
