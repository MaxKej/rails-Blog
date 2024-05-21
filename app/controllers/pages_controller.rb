class PagesController < ApplicationController
  def home
  end

  def find
    @posts = Post.where("title LIKE ?", "%#{params[:title]}%")
  end

  def privacy
  end

  def show
    render params[:id]
  end
end


