class CommentsController < ApplicationController

  before_action :set_comment, only: [:destroy, :update]
  before_action :authenticate_admin!, only: [:destroy, :update]

  def list
    @comments = Comment.page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.new
  end


  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end


  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id if user_signed_in?

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      redirect_to @post, alert: 'Failed to create comment.'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.post, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.post, notice: 'Comment was successfully destroyed.'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to @comment.post, alert: 'You are not authorized to perform this action.'
    end
  end
end
