class CommentsController < ApplicationController

  def create
    @post = Post.find_by_id(params[:post_id])
    @comment = Comment.build_from(@post, current_user.id, params[:body])
    @parent_comment = Comment.find_by_id(params[:parent_comment_id])

    if @comment.save
      if @parent_comment
        @comment.move_to_child_of(@parent_comment)
      end
      redirect_to :back
    else
      redirect_to :back, :notice => 'Please make sure to type your comment before clicking the submit button.'
    end
  end

end
