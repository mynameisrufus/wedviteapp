class Blog::PostsController < ApplicationController
  layout 'blog/application'

  respond_to :html, :json

  def robots
    render text: '', layout: false
  end

  def index
    @posts = Post.published.order("created_at DESC").page(params[:page]).per(5)
    respond_with @posts
  end

  def show
    @post = Post.published.friendly.find params[:id]
  end

  def edit
    if admin_signed_in?
      @post = Post.friendly.find params[:id]
    else
      render inline: "You must be signed in"
    end
  end

  def update
    if admin_signed_in?
      @post = Post.friendly.find params[:id]
      @post.update_attributes params[:post]
    end
    redirect_to edit_post_path @post
  end
end
