module Blorgh
  class CommentsController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(params[:comment])
      flash[:notice] = "Comment has been created!"
      redirect_to post_path
    end
  end
end
