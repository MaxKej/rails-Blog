require 'wicked_pdf'

class PagesController < ApplicationController
  def home
  end

  def find
    @posts = Post.where("title LIKE ?", "%#{params[:title]}%").page(params[:page]).per(10)
  end


  def privacy
  end

  def show
    render params[:id]
  end
end


