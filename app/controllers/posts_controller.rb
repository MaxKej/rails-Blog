class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :download_pdf, :edit, :update, :destroy]
  before_action :authorize_admin, only: [:edit, :update, :destroy, :download_pdf]

  def list
    @posts = Post.page(params[:page]).per(10)
  end

  def show
    # @post = Post.find(params[:id])
    @comments = @post.comments.page(params[:page]).per(10)
  end

  def download_pdf
    @comments = @post.comments

    respond_to do |format|
      format.html { render plain: "This action is only for PDF format requests." }
      format.pdf do
        render pdf: "post_#{@post.id}",
               template: 'posts/show.pdf.erb',
               layout: 'pdf.html'
      end
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_admin
    unless current_user&.admin?
      redirect_to @comment.post, alert: 'You are not authorized to perform this action.'
    end
  end
end
