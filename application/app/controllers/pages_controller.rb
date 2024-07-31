class PagesController < ApplicationController
  def home
  end

  def find
    # @posts = Post.where("title LIKE ?", "%#{params[:title]}%").page(params[:page]).per(10)
    query = params[:title].present? ? { match: { title: params[:title] } } : { match_all: {} }
    @posts = Post.search(query).page(params[:page]).per(10).records
  end


  def privacy
  end

  def show
    render params[:id]
  end
end


