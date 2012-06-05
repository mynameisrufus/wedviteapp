class Blog::PostsController < ApplicationController
  layout 'blog/application'

  respond_to :html, :json

  def robots
    render text: '', layout: false
  end

  def index
    @posts = Post.order("created_at DESC").page(params[:page]).per(5)
    respond_with @posts
  end

  def show
    @post = Post.find params[:id]
  end
end
